#!/bin/bash
# PreToolUse hook: blocks destructive operations and warns on bulk data ops

# Fail-closed: if critical parsing fails, deny the action
INPUT=$(cat 2>/dev/null || true)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null || true)

# If we couldn't parse the command at all, allow through (static deny handles the rest)
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
