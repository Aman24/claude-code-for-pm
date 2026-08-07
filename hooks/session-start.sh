#!/bin/bash
# UserPromptSubmit hook: surfaces previous-session context on first message
# Checks for pre-compact logs and stale product contexts
#
# No `set -e`, no ERR trap. Under `set -euo pipefail` the `ls` below fails on any
# machine with no pre-compact logs yet — the ordinary first-run case — pipefail
# propagates it, the trap fires, and the stale-context check underneath never
# runs. The hook printed "continuing safely" and skipped half its job.

# stat has no portable flag for mtime: GNU uses -c %Y, BSD/macOS uses -f %m.
file_mtime() {
  stat -c %Y "$1" 2>/dev/null || stat -f %m "$1" 2>/dev/null || echo 0
}

PROJECT_DIR="$(pwd)"
NOW=$(date +%s)

# Check for pre-compact logs from last session
LOG_DIR="$HOME/.claude/logs"
if [ -d "$LOG_DIR" ]; then
  LATEST_LOG=$(ls -t "$LOG_DIR"/pre-compact-*.log 2>/dev/null | head -1 || true)
  if [ -n "$LATEST_LOG" ] && [ -f "$LATEST_LOG" ]; then
    MTIME=$(file_mtime "$LATEST_LOG")
    if [ "$MTIME" -gt 0 ] 2>/dev/null; then
      LOG_AGE=$(( (NOW - MTIME) / 3600 ))
      if [ "$LOG_AGE" -lt 24 ]; then
        echo "PREVIOUS SESSION CONTEXT: Found recent session state from ${LOG_AGE}h ago. Consider loading: $LATEST_LOG" >&2
      fi
    fi
  fi
fi

# Check for stale product contexts (>14 days)
if [ -d "$PROJECT_DIR/products" ]; then
  for ctx in "$PROJECT_DIR"/products/*/CLAUDE.md; do
    [ -f "$ctx" ] || continue
    MTIME=$(file_mtime "$ctx")
    # mtime 0 means stat failed on this platform; skip rather than report
    # every context as 20,000 days stale.
    [ "$MTIME" -gt 0 ] 2>/dev/null || continue
    FILE_AGE=$(( (NOW - MTIME) / 86400 ))
    if [ "$FILE_AGE" -gt 14 ]; then
      PRODUCT=$(basename "$(dirname "$ctx")")
      echo "STALE CONTEXT: products/$PRODUCT/CLAUDE.md is ${FILE_AGE} days old. May need refresh." >&2
    fi
  done
fi

exit 0
