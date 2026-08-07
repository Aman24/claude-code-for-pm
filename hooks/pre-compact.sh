#!/bin/bash
# PreCompact hook: preserves working context before context window compaction
# Prevents losing track of in-flight work during long sessions
#
# No `set -e`, no ERR trap. The snapshot below is best-effort by design — a missing
# products/ directory or an absent git repo is normal, not an error. Under `set -e`
# the trap fired on those ordinary cases, truncating the log AND replacing the full
# preservation message with the one-line fallback. The instructions at the end are
# the part that actually matters, so nothing above them may abort the script.

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
LOG_DIR="$HOME/.claude/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/pre-compact-$TIMESTAMP.log"

{
  echo "=== PRE-COMPACT STATE SNAPSHOT ==="
  echo "Timestamp: $TIMESTAMP"
  echo ""

  # Git state if in a repo
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "--- Git State ---"
    echo "Branch: $(git branch --show-current 2>/dev/null || echo 'unknown')"
    echo "Modified files:"
    git status --porcelain 2>/dev/null | head -20
    echo ""
    echo "--- Recent Commits (context) ---"
    git log --oneline -5 2>/dev/null || true
    echo ""
  fi

  # Current working directory
  echo "--- Working Directory ---"
  echo "CWD: $(pwd)"
  echo ""

  # Recently modified files in products/ (likely active work).
  # -mmin is portable; the old `-newer <(date -d ...)` form needed GNU date and
  # process substitution, and silently matched nothing on macOS.
  echo "--- Recently Modified Product Files (last 2h) ---"
  find products/ -name "*.md" -type f -mmin -120 2>/dev/null | head -15 || true
  echo ""

  # Active tasks across products
  echo "--- Active Task Files ---"
  for todo in products/*/tasks/todo.md; do
    if [ -f "$todo" ]; then
      PRODUCT=$(echo "$todo" | sed 's|products/||;s|/tasks/todo.md||')
      # grep -c prints 0 and exits 1 when nothing matches, so `|| echo 0` used to
      # append a second 0 and produce "0\n0" — an invalid integer.
      IN_PROGRESS=$(grep -c "In Progress\|WIP\|- \[ \]" "$todo" 2>/dev/null || true)
      [ -z "$IN_PROGRESS" ] && IN_PROGRESS=0
      if [ "$IN_PROGRESS" -gt 0 ] 2>/dev/null; then
        echo "  $PRODUCT: $IN_PROGRESS active items"
      fi
    fi
  done
  echo ""

} > "$LOG_FILE" 2>&1

# Output context preservation instructions to Claude
cat <<'COMPACT_MSG'
CONTEXT PRESERVATION — You MUST retain all of the following through compaction:

1. PRODUCT: Which product(s) this session is working on
2. TASK: Current task, its status, and what step we're on
3. DECISIONS: Key decisions made this session (and their rationale)
4. MODIFIED FILES: All files created or modified but not yet committed
5. PENDING ACTIONS: Any action items or next steps discussed
6. ARCHITECTURAL CONTEXT: Any design choices or trade-offs established
7. BLOCKERS: Anything that was blocked or needs follow-up
8. OPERATING MODE: Which context mode (Strategy/Execution/Review/Analyse) is active

State log saved to ~/.claude/logs/ for session-start recovery.
COMPACT_MSG

exit 0
