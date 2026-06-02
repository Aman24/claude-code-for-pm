#!/bin/bash
# UserPromptSubmit hook: surfaces previous-session context on first message
# Checks for pre-compact logs and stale product contexts
set -euo pipefail

# Fail-closed: if this hook errors, log and continue (non-blocking hook)
trap 'echo "Hook error in session-start.sh - continuing safely" >&2; exit 0' ERR

PROJECT_DIR="$(pwd)"

# Check for pre-compact logs from last session
LOG_DIR="$HOME/.claude/logs"
if [ -d "$LOG_DIR" ]; then
  LATEST_LOG=$(ls -t "$LOG_DIR"/pre-compact-*.log 2>/dev/null | head -1)
  if [ -n "$LATEST_LOG" ]; then
    LOG_AGE=$(( ($(date +%s) - $(stat -c %Y "$LATEST_LOG" 2>/dev/null || echo 0)) / 3600 ))
    if [ "$LOG_AGE" -lt 24 ]; then
      echo "PREVIOUS SESSION CONTEXT: Found recent session state from ${LOG_AGE}h ago. Consider loading: $LATEST_LOG" >&2
    fi
  fi
fi

# Check for stale product contexts (>14 days)
if [ -d "$PROJECT_DIR/products" ]; then
  for ctx in "$PROJECT_DIR"/products/*/CLAUDE.md; do
    if [ -f "$ctx" ]; then
      FILE_AGE=$(( ($(date +%s) - $(stat -c %Y "$ctx" 2>/dev/null || echo 0)) / 86400 ))
      if [ "$FILE_AGE" -gt 14 ]; then
        PRODUCT=$(basename "$(dirname "$ctx")")
        echo "STALE CONTEXT: products/$PRODUCT/CLAUDE.md is ${FILE_AGE} days old. May need refresh." >&2
      fi
    fi
  done
fi

exit 0
