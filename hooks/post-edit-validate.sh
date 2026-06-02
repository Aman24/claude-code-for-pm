#!/bin/bash
# PostToolUse hook: validates edits beyond the basic write check
# Checks markdown formatting, catches common issues
set -euo pipefail

# Fail-closed: if this hook errors, log and exit gracefully
trap 'echo "Hook error in post-edit-validate.sh - continuing safely" >&2; exit 0' ERR

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Skip non-markdown files
if ! echo "$FILE_PATH" | grep -qiE '\.md$'; then
  exit 0
fi

# Check for broken markdown links (common issue)
if [ -f "$FILE_PATH" ]; then
  BROKEN_LINKS=$(grep -cE '\[.*\]\(\s*\)' "$FILE_PATH" 2>/dev/null || echo 0)
  if [ "$BROKEN_LINKS" -gt 0 ]; then
    echo "WARNING: Found $BROKEN_LINKS empty markdown links in $FILE_PATH. Check for [text]() patterns." >&2
  fi
fi

# Check for accidental credential patterns
if [ -f "$FILE_PATH" ]; then
  if grep -qiE '(password|secret|api.?key|token)\s*[:=]\s*["\x27]?[a-zA-Z0-9]{8,}' "$FILE_PATH" 2>/dev/null; then
    echo "SECURITY WARNING: Possible credentials detected in $FILE_PATH. Review before committing." >&2
  fi
fi

# Reminder for skills if a new skill was added
if echo "$FILE_PATH" | grep -qi ".claude/skills/"; then
  echo "Reminder: If this is a new skill, register it in your skills index." >&2
fi

exit 0
