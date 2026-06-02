#!/bin/bash
# PreToolUse hook: scans content about to be written/edited for hardcoded secrets
# Blocks the write BEFORE it happens
#
# IMPORTANT: No `set -e`, no ERR trap on this hook.
# An earlier version used `set -euo pipefail` + ERR trap and bricked ALL Write/Edit
# operations the first time the hook errored. The lesson: hooks that block by default
# are a foot-gun. Fail-open on parse errors, fail-explicit on detection.

INPUT=$(cat 2>/dev/null || true)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null || true)
CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty' 2>/dev/null || true)

# If we couldn't parse, allow through (static deny handles protected paths)
if [ -z "$FILE_PATH" ] && [ -z "$CONTENT" ]; then
  exit 0
fi

BLOCKED=""

# --- Phase 1: Check file path against protected patterns ---

if [ -n "$FILE_PATH" ]; then
  if echo "$FILE_PATH" | grep -qiE '\.(pem|key|p12|pfx|keystore)$'; then
    BLOCKED="Writing to protected key/cert file: $FILE_PATH"
  fi

  if echo "$FILE_PATH" | grep -qiE '(id_rsa|id_ed25519|authorized_keys|known_hosts)'; then
    BLOCKED="Writing to SSH file: $FILE_PATH"
  fi

  if echo "$FILE_PATH" | grep -qiE '\.env(\.[a-z]+)?$'; then
    BLOCKED="Writing to env file: $FILE_PATH"
  fi
fi

# --- Phase 2: Scan content for hardcoded secrets ---

if [ -n "$CONTENT" ]; then
  # AWS keys
  if echo "$CONTENT" | grep -qE 'AKIA[0-9A-Z]{16}'; then
    BLOCKED="AWS Access Key found in content"
  fi

  # Google/Firebase API keys
  if echo "$CONTENT" | grep -qE 'AIza[0-9A-Za-z_-]{35}'; then
    BLOCKED="Google/Firebase API key found in content"
  fi

  # Private key blocks
  if echo "$CONTENT" | grep -qE 'BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY'; then
    BLOCKED="Private key found in content"
  fi

  # Google service account
  if echo "$CONTENT" | grep -qE '"type"[[:space:]]*:[[:space:]]*"service_account"'; then
    BLOCKED="Google service account JSON found in content"
  fi

  # Stripe live keys
  if echo "$CONTENT" | grep -qE '(sk_live|pk_live)_[a-zA-Z0-9]{20,}'; then
    BLOCKED="Live Stripe key found in content"
  fi

  # Razorpay live keys
  if echo "$CONTENT" | grep -qE 'rzp_live_[a-zA-Z0-9]{14,}'; then
    BLOCKED="Live Razorpay key found in content"
  fi

  # JWT tokens
  if echo "$CONTENT" | grep -qE 'eyJ[a-zA-Z0-9_-]{20,}\.eyJ[a-zA-Z0-9_-]{20,}\.[a-zA-Z0-9_-]{20,}'; then
    BLOCKED="JWT token found in content"
  fi

  # Database connection strings with credentials
  if echo "$CONTENT" | grep -qiE '(mongodb|mysql|postgres|redis|amqp)(\+srv)?://[^[:space:]"]+:[^[:space:]"]+@'; then
    BLOCKED="Database connection string with credentials found in content"
  fi
fi

# --- Decision ---

if [ -n "$BLOCKED" ]; then
  echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PreToolUse\",\"permissionDecision\":\"deny\",\"permissionDecisionReason\":\"BLOCKED: $BLOCKED. Use environment variables instead.\"}}"
  exit 0
fi

# Allow the write
exit 0
