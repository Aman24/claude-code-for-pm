#!/bin/bash
# PreToolUse hook: blocks destructive operations and warns on bulk data ops

# Fail-open on parse, fail-explicit on detection. This hook cannot deny what it
# cannot read, so the static deny list in settings.json is the real backstop for
# anything critical. (An earlier version claimed "fail-closed" here while the very
# next line allowed the command through — the comment was wrong, not the code.)
HOOK_LIB="$(dirname "$0")/lib/hookjson.sh"
[ -f "$HOOK_LIB" ] && . "$HOOK_LIB"
declare -f hj_field >/dev/null 2>&1 || hj_field() { printf ''; }

INPUT=$(cat 2>/dev/null || true)
COMMAND=$(hj_field "$INPUT" tool_input.command)

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Block rm -rf
if echo "$COMMAND" | grep -qE 'rm\s+-rf\s+'; then
  echo "BLOCKED: rm -rf is not allowed. Use targeted file removal instead." >&2
  exit 2
fi

# Block force push
if echo "$COMMAND" | grep -qE 'git\s+push\s+--force'; then
  echo "BLOCKED: Force push is not allowed. Use regular push." >&2
  exit 2
fi

# Warn on bulk data operations
if echo "$COMMAND" | grep -qiE '(import|bulk|migrate|drop|truncate|delete.*all)'; then
  echo "WARNING: This looks like a bulk/destructive data operation. Confirm with the user before proceeding. Check .claude/hooks/guardrails.md for applicable rules." >&2
fi

exit 0
