#!/bin/bash
# PostToolUse hook: validates edits beyond the basic write check
# Checks markdown formatting, catches common issues
#
# No `set -e`, no ERR trap. See post-write-check.sh for why: the trap fires on the
# normal path, and the hook reports success while skipping every check.

HOOK_LIB="$(dirname "$0")/lib/hookjson.sh"
[ -f "$HOOK_LIB" ] && . "$HOOK_LIB"
declare -f hj_field >/dev/null 2>&1 || hj_field() { printf ''; }

INPUT=$(cat 2>/dev/null || true)
FILE_PATH=$(hj_field "$INPUT" tool_input.file_path tool_input.notebook_path)

# Skip non-markdown files
if ! echo "$FILE_PATH" | grep -qiE '\.md$'; then
  exit 0
fi

# Check for broken markdown links (common issue)
if [ -f "$FILE_PATH" ]; then
  # `grep -c` prints 0 AND exits 1 when there are no matches, so `|| echo 0`
  # appended a second 0 and produced "0\n0" — which then failed the integer test.
  # The ERR trap used to swallow that and print "continuing safely" instead.
  BROKEN_LINKS=$(grep -cE '\[.*\]\(\s*\)' "$FILE_PATH" 2>/dev/null || true)
  [ -z "$BROKEN_LINKS" ] && BROKEN_LINKS=0
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
