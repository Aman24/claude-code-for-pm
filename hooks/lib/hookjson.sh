#!/bin/bash
# Shared stdin-JSON reader for Claude Code hooks. Source this; don't execute it.
#
# WHY THIS EXISTS
# ---------------
# Hooks receive their payload as JSON on stdin. The obvious way to read it is `jq`.
# The problem: jq is not installed by default on macOS, on Windows under Git Bash,
# or in most CI images. When it is missing, `jq -r '.tool_input.command'` fails,
# the variable ends up empty, and the hook hits its own "couldn't parse, allow
# through" branch and exits 0.
#
# The hook does not error. It does not warn. It reports success and does nothing.
# A guard that silently allows everything is worse than no guard, because you
# stop checking.
#
# This reader has no external dependencies beyond a POSIX shell. It tries Python
# (present on virtually every dev machine, under either name) and falls back to
# grep/sed for flat string fields.
#
# RULES FOR ANY HOOK THAT SOURCES THIS
# ------------------------------------
# 1. Never add `set -e`, `set -u`, `set -o pipefail`, or an ERR trap. A hook that
#    aborts on the first non-zero exit will abort on a grep that found nothing,
#    which is the normal case. PostToolUse hooks are not exempt.
# 2. Fail open on parse failure, fail explicit on detection. Deny only when you
#    positively identified something.
# 3. Prove the hook fires. An unverified hook is probably dead. See the tests at
#    the bottom of hooks/README.md.

# hj_field <json> <dotted.path> [more.paths...]
# Prints the first path that resolves to a non-empty scalar. Prints nothing
# otherwise. Never fails.
hj_field() {
  local _json="$1"; shift
  [ -z "$_json" ] && return 0
  [ "$#" -eq 0 ] && return 0

  local _py=""
  if command -v python3 >/dev/null 2>&1; then _py=python3
  elif command -v python >/dev/null 2>&1; then _py=python
  fi

  local _out=""
  if [ -n "$_py" ]; then
    _out=$(printf '%s' "$_json" | "$_py" -c '
import sys, json
try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for path in sys.argv[1:]:
    cur = data
    for part in path.split("."):
        if isinstance(cur, dict):
            cur = cur.get(part)
        else:
            cur = None
            break
    if isinstance(cur, bool) or cur is None:
        continue
    if isinstance(cur, (str, int, float)):
        text = str(cur)
        if text:
            sys.stdout.write(text)
            break
' "$@" 2>/dev/null || true)
  fi

  # Fallback: pull a flat "key": "value" pair out of the raw JSON. Handles the
  # common case (a string field one or two levels deep) and nothing more.
  if [ -z "$_out" ]; then
    local _path _key
    for _path in "$@"; do
      _key="${_path##*.}"
      _out=$(printf '%s' "$_json" \
        | grep -o "\"${_key}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" \
        | head -1 \
        | sed 's/^"[^"]*"[[:space:]]*:[[:space:]]*"//; s/"$//' 2>/dev/null || true)
      [ -n "$_out" ] && break
    done
  fi

  printf '%s' "$_out"
}

# hj_deny <reason>
# Emits the PreToolUse deny response Claude Code expects, and exits 0.
# Exit 0 is correct here: the JSON carries the decision, not the exit code.
hj_deny() {
  local _reason="$1"
  _reason=${_reason//\\/\\\\}
  _reason=${_reason//\"/\\\"}
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$_reason"
  exit 0
}
