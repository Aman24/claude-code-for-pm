# Hooks

The safety + automation layer. Each hook is a small shell script that fires on a specific Claude Code lifecycle event — secret scanning, destructive-command blocking, context preservation, session orientation.

## What ships here

| Hook | Event | What it does |
|---|---|---|
| **`pre-bash-guard.sh`** | PreToolUse (Bash) | Blocks `rm -rf` and `git push --force`. Warns on bulk data ops. |
| **`write-guard.sh`** | PreToolUse (Write/Edit) | Scans content for AWS / Google / Stripe / Razorpay / JWT / DB-credential patterns. Blocks the write before it lands. |
| **`user-prompt-scan.sh`** | UserPromptSubmit | Catches credentials pasted into the conversation by the user. Warns; doesn't block. |
| **`post-write-check.sh`** | PostToolUse (Write/Edit) | Reminds you to update related context (CLAUDE.md, MEMORY.md, decision records) after edits to product or decision files. |
| **`post-edit-validate.sh`** | PostToolUse (Edit) | Light markdown validation — flags empty `[]()` links and accidental credential patterns in just-edited files. |
| **`pre-compact.sh`** | PreCompact | Snapshots git state, working dir, and active task files; emits an instruction block to preserve context through compaction. |
| **`session-start.sh`** | UserPromptSubmit (first msg) | Surfaces pre-compact logs from prior sessions; flags stale product-context files (>14 days). |
| **`lib/hookjson.sh`** | (shared library) | Dependency-free stdin-JSON reader. Sourced by every hook that reads a payload. |
| **`guardrails.md`** | (reference doc) | The non-negotiable check list. A portable template — fork it and fill in your own anchor-event / data-op rules. |

## Wiring

Add to `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      { "matcher": "Bash", "hooks": [{ "type": "command", "command": ".claude/hooks/pre-bash-guard.sh" }] },
      { "matcher": "Write|Edit", "hooks": [{ "type": "command", "command": ".claude/hooks/write-guard.sh" }] }
    ],
    "PostToolUse": [
      { "matcher": "Write|Edit", "hooks": [{ "type": "command", "command": ".claude/hooks/post-write-check.sh" }] },
      { "matcher": "Edit", "hooks": [{ "type": "command", "command": ".claude/hooks/post-edit-validate.sh" }] }
    ],
    "UserPromptSubmit": [
      { "hooks": [
        { "type": "command", "command": ".claude/hooks/user-prompt-scan.sh" },
        { "type": "command", "command": ".claude/hooks/session-start.sh" }
      ]}
    ],
    "PreCompact": [
      { "hooks": [{ "type": "command", "command": ".claude/hooks/pre-compact.sh" }] }
    ]
  }
}
```

Make the scripts executable: `chmod +x .claude/hooks/*.sh`

## Fail-open vs fail-closed

`write-guard.sh` is **fail-open** on parse errors — if the script can't read its input, the write goes through. This is deliberate. An earlier version used `set -e` + `ERR trap` and bricked *all* Write/Edit operations the first time the hook errored. The lesson: hooks that block by default are a foot-gun; hooks that block on detection are a safety net.

`pre-bash-guard.sh` follows the same pattern — only explicit `exit 2` blocks.

The reverse pattern (fail-closed on hook error) is appropriate when the cost of a single missed check is catastrophic — but for PM-scope use, the lesson held: explicit blocks beat implicit ones.

## No jq, and why that matters

These hooks previously parsed their stdin payload with `jq`. That was a mistake, and it took months to notice.

`jq` isn't installed by default on macOS, on Windows under Git Bash, or in most CI images. Where it's missing, `jq -r '.tool_input.command'` produces nothing, the variable comes back empty, and the hook takes its own "couldn't parse, allow through" branch and exits 0. No error. No warning. **A security layer reporting success while doing nothing at all.**

Five of the seven scripts here were inert on any machine without `jq`, including the machine they were written on. `pre-bash-guard.sh` even carried a comment claiming it was fail-closed, two lines above the code that let everything through.

`lib/hookjson.sh` replaces that with a reader that needs nothing beyond a POSIX shell. It tries Python under either name and falls back to `grep`/`sed`.

**The rule that follows: never add `set -e`, `set -u`, `set -o pipefail`, or an ERR trap to a hook.** Under `set -e`, a `grep` that finds nothing is a non-zero exit — the ordinary case — so the trap fires on the happy path and the hook prints a reassuring message instead of running its checks. This applies to PostToolUse hooks too, which is where it bit hardest here.

Removing the traps immediately exposed two real bugs they had been masking: a `grep -c ... || echo 0` that produced `"0\n0"` and failed its own integer test, and a `set -e` abort in `session-start.sh` that skipped the stale-context check on every machine with no prior logs.

## Portability notes

- Requires `bash`. On Windows, use WSL or Git Bash. No `jq`, no `uv`, no package installs.
- `stat` has no portable mtime flag, so `session-start.sh` wraps GNU `-c %Y` and BSD `-f %m` and skips the check rather than reporting every file as decades stale when both fail.
- `pre-compact.sh` uses `find -mmin`, which is portable. The previous `-newer <(date -d ...)` form needed GNU `date` plus process substitution and matched nothing on macOS.

## Testing

An unverified hook is probably dead. After any change, run both a **positive** control that must trigger and a **negative** control that must stay silent. The negative one finds the real bugs.

```sh
# Positive: must print BLOCKED and exit 2
echo '{"tool_input":{"command":"rm -rf /tmp/x"}}' | bash hooks/pre-bash-guard.sh; echo "exit=$?"

# Negative: must print nothing and exit 0
echo '{"tool_input":{"command":"ls -la"}}' | bash hooks/pre-bash-guard.sh; echo "exit=$?"

# Positive: must emit permissionDecision":"deny"
echo '{"tool_input":{"file_path":"a.md","content":"AKIAIOSFODNN7EXAMPLE"}}' | bash hooks/write-guard.sh

# Negative: must print nothing
echo '{"tool_input":{"file_path":"notes.md","content":"just some prose"}}' | bash hooks/write-guard.sh

# Positive: must warn about an AWS key
echo '{"prompt":"use AKIAIOSFODNN7EXAMPLE"}' | bash hooks/user-prompt-scan.sh

# Positive: must print a reminder
echo '{"tool_input":{"file_path":"products/alpha/CLAUDE.md"}}' | bash hooks/post-write-check.sh
```

If a positive control prints nothing, the hook is not running. Check that it's executable, that the path in `settings.json` is right, and that the payload field names still match your Claude Code version — `user-prompt-scan.sh` accepts both `prompt` and `user_prompt` for that reason.
