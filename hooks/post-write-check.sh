#!/bin/bash
# PostToolUse hook: reminds to check naming conventions and update related context
# Fires after Write/Edit on product or decision files
set -euo pipefail

# Fail-closed: if this hook errors, log and exit gracefully
trap 'echo "Hook error in post-write-check.sh - continuing safely" >&2; exit 0' ERR

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if echo "$FILE_PATH" | grep -qi "products/"; then
  echo "Reminder: Product context file modified. Verify the change aligns with the product's CLAUDE.md and check if MEMORY.md needs updating." >&2
fi

if echo "$FILE_PATH" | grep -qi "docs/decisions/"; then
  echo "Reminder: Decision record modified. Ensure it follows ADR format and is referenced in the relevant product CLAUDE.md." >&2
fi

exit 0
