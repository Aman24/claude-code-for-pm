# Guardrails — Non-Negotiable Checks

These apply in every session regardless of task. The floor under everything else.

This file is a portable template. The structure is what's reusable; the specifics under each section are yours to fill in based on your products and what matters to you.

## Always Check Before Proceeding

### Scope
- Is the scope of this task clear? → If not, ask before starting.
- Does this touch more than one product? → Use the cross-product update pattern.
- Is this reversible? → If not, confirm before executing.

### Anchor event (replace with your launch / release window)
- Is this change going live during the anchor-event window? → Stakeholder review required.
- Are any anchor-event-critical flows affected? → STOP and confirm.
- *[Replace with the specific products, dates, or release windows you defend.]*

### Bulk data operations
- Is data being modified in bulk? → Confirm + backup first. *(Also caught by `pre-bash-guard.sh`.)*
- Are migrations involved? → Verify in a non-prod environment first.
- Are imports running? → Validate the source schema before merging.

### Domain-specific (fill in your own)
- *[Replace with the irreversible / high-blast-radius checks for your domain — content imports, schema migrations, billing changes, etc.]*

## Security

- Are any credentials being written to non-product files? → BLOCK (creds live in env vars or vault). *(Enforced by `write-guard.sh` and `user-prompt-scan.sh`.)*
- Is an MCP server being added? → Verify the package name (typosquatting risk).
- Is a new skill / hook being installed from an external source? → Review contents before enabling.
- Are any external URLs being fetched in hooks? → Flag for review (prompt-injection vector).

---

These rules are checked by humans (you, the PM). The scripts in this folder enforce a subset of them automatically — they catch the slip-ups; the list above prevents the deliberate mistakes.
