# Operating Rules

These are the hygiene rules for working sessions. Violating them silently is what breaks compounding — sessions stop helping each other, the system stops self-improving.

- **Never mix product contexts in the same working session without flagging it.** If a question pulls in two products, stop and name it explicitly. Cross-product reasoning is fine; accidental cross-product reasoning is the source of most subtle errors.

- **Always confirm scope before making data changes** — imports, exports, bulk operations, anything that touches production state. The cost of asking once is far less than the cost of an undo.

- **The next milestone is the lens.** If a decision doesn't serve the next major moment you're working toward, flag it. Activity that doesn't land is just activity.

- **Two tracks are usually running:** the public-facing track and the internal-ops track. Name which one each session is on.

- **No bloat.** Never create files outside the product-scoped directories or the docs folder without discussing first. New folders are commitments; treat them as such.

- **Elegance check.** For non-trivial code or scripts — ask "is there a more elegant way?" before shipping. Prototypes may graduate to production; sloppy first drafts shouldn't.

- **Self-improvement.** After a correction, propose a `CLAUDE.md` edit if the lesson is reusable. Log it in `lessons.md` with date, context, and the rule that came out of it. The harness should get smarter every week, not just longer.

- **Model suggestion.** Proactively recommend the right model (Opus / Sonnet / Haiku) at the start of a session based on task type, so the operator can switch deliberately rather than running everything on the default.

## What this isn't

- This isn't a style guide for code. It's a discipline for working sessions.
- It's not exhaustive. Add rules when a pattern breaks twice.
- It's not permanent. Delete a rule if it stops earning its keep.
