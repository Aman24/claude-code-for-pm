#!/bin/bash
# PostToolUse hook: reminds to check naming conventions and update related context
# Fires after Write/Edit on product or decision files
#
# No `set -e`, no ERR trap here either. PostToolUse hooks are not exempt from the
# rule in write-guard.sh: under `set -e` a grep that finds nothing is a non-zero
# exit, so the trap fires on the normal path and the hook prints "continuing
# safely" instead of running its checks. It looks healthy in the transcript and
# does nothing.

HOOK_LIB="$(dirname "$0")/lib/hookjson.sh"
[ -f "$HOOK_LIB" ] && . "$HOOK_LIB"
declare -f hj_field >/dev/null 2>&1 || hj_field() { printf ''; }

INPUT=$(cat 2>/dev/null || true)
FILE_PATH=$(hj_field "$INPUT" tool_input.file_path tool_input.notebook_path)

if echo "$FILE_PATH" | grep -qi "products/"; then
  echo "Reminder: Product context file modified. Verify the change aligns with the product's CLAUDE.md and check if MEMORY.md needs updating." >&2
fi

if echo "$FILE_PATH" | grep -qi "docs/decisions/"; then
  echo "Reminder: Decision record modified. Ensure it follows ADR format and is referenced in the relevant product CLAUDE.md." >&2
fi

exit 0
