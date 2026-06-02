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

## Portability notes

- The scripts assume `bash` + `jq`. On Windows, use WSL or Git Bash.
- `pre-compact.sh` and `session-start.sh` use GNU-style `date -d` and `stat -c` — macOS users may need to swap for BSD equivalents (or wrap in a portability shim).
