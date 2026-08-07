#!/bin/bash
# UserPromptSubmit hook: scans user input for accidentally pasted credentials
# Catches API keys, tokens, passwords before they enter the conversation

HOOK_LIB="$(dirname "$0")/lib/hookjson.sh"
[ -f "$HOOK_LIB" ] && . "$HOOK_LIB"
declare -f hj_field >/dev/null 2>&1 || hj_field() { printf ''; }

INPUT=$(cat 2>/dev/null || true)
# Field name has varied across versions — accept both rather than guess.
USER_MSG=$(hj_field "$INPUT" prompt user_prompt)

if [ -z "$USER_MSG" ]; then
  exit 0
fi

WARNINGS=""

# AWS keys (AKIA...)
if echo "$USER_MSG" | grep -qE 'AKIA[0-9A-Z]{16}'; then
  WARNINGS="${WARNINGS}\n- AWS Access Key detected (AKIA...)"
fi

# Generic long API keys / tokens
if echo "$USER_MSG" | grep -qE '(api[_-]?key|api[_-]?secret|access[_-]?token|auth[_-]?token|bearer)[[:space:]]*[:=]' ; then
  WARNINGS="${WARNINGS}\n- API key or token pattern detected"
fi

# Private key blocks
if echo "$USER_MSG" | grep -qE 'BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY'; then
  WARNINGS="${WARNINGS}\n- Private key block detected"
fi

# Google service account JSON
if echo "$USER_MSG" | grep -qE '"type"[[:space:]]*:[[:space:]]*"service_account"'; then
  WARNINGS="${WARNINGS}\n- Google service account JSON detected"
fi

# JWT tokens
if echo "$USER_MSG" | grep -qE 'eyJ[a-zA-Z0-9_-]{20,}\.eyJ[a-zA-Z0-9_-]{20,}\.[a-zA-Z0-9_-]{20,}'; then
  WARNINGS="${WARNINGS}\n- JWT token detected"
fi

# Firebase / GCP keys
if echo "$USER_MSG" | grep -qE 'AIza[0-9A-Za-z_-]{35}'; then
  WARNINGS="${WARNINGS}\n- Google/Firebase API key detected (AIza...)"
fi

# Stripe keys
if echo "$USER_MSG" | grep -qE '(sk_live|pk_live|sk_test|pk_test)_[a-zA-Z0-9]{20,}'; then
  WARNINGS="${WARNINGS}\n- Stripe key detected"
fi

# Razorpay keys
if echo "$USER_MSG" | grep -qE 'rzp_(live|test)_[a-zA-Z0-9]{14,}'; then
  WARNINGS="${WARNINGS}\n- Razorpay key detected"
fi

# MongoDB connection strings with creds
if echo "$USER_MSG" | grep -qE 'mongodb(\+srv)?://[^[:space:]]+:[^[:space:]]+@'; then
  WARNINGS="${WARNINGS}\n- MongoDB connection string with credentials detected"
fi

# Generic DB connection strings
if echo "$USER_MSG" | grep -qiE '(mysql|postgres|redis|amqp)://[^[:space:]]+:[^[:space:]]+@'; then
  WARNINGS="${WARNINGS}\n- Database connection string with credentials detected"
fi

# Password patterns
if echo "$USER_MSG" | grep -qiE '(password|passwd|pwd)[[:space:]]*[:=][[:space:]]*[^[:space:]]{8,}'; then
  WARNINGS="${WARNINGS}\n- Password pattern detected"
fi

if [ -n "$WARNINGS" ]; then
  echo "CREDENTIAL SCAN WARNING: Your message may contain sensitive data:" >&2
  echo -e "$WARNINGS" >&2
  echo "Consider removing before sending. They persist in conversation context and logs." >&2
fi

exit 0
