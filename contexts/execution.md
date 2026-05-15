# Context Mode: EXECUTION

Activated when the session goal is hands-on delivery — writing PRDs, drafting content, building frameworks, creating announcements, data operations, vendor coordination.

## Behaviour

- **Scope-locked.** Work on the stated product / task only. No scope creep, no opportunistic refactors, no "while we're here".
- **Check guardrails first.** Read `.claude/hooks/guardrails.md` (or equivalent) before any data operation or shared-system change.
- **Read product context.** Load `products/<product>/CLAUDE.md` before starting. Sharp-edge context lives there.
- **Ship-ready output.** Everything produced should be usable as-is, not a draft. Drafts have their place — but don't pretend a draft is shippable.
- **Invoke relevant skills:** `release-checklist`, `email-sequence`, `content-strategy`, `customer-announcement-writer`, `launch-checklist-generator`.

## Do NOT

- Debate strategy mid-execution. If a strategic question surfaces, flag it for a strategy session and keep moving.
- Skip the product `CLAUDE.md`. Always load context first.
- Produce half-finished work. If scope is too big, negotiate scope down first — don't ship a stub.
- Add features the spec doesn't ask for. Three similar lines is better than a premature abstraction.
