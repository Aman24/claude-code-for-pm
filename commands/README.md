# Commands

Slash commands that drive the operating model. Drop these into `.claude/commands/` and invoke by name.

## Session & context
- **`/session-start`** — Orient at the start of a session: state the product + goal, load the relevant context.
- **`/context`** — Switch operating mode (strategy / execution / review / analyse).

## Learning loop
- **`/learn`** — Capture a session's wins and gotchas into persistent memory so they compound.
- **`/evolve`** — Periodically promote recurring memory patterns into commands, skills, agents, or guardrails.

## Automation & monitoring
- **`/loop`** — Run a prompt or command on a recurring interval within a session (health checks, countdowns, pre-meeting prep).
- **`/whats-new`** — Scan recent Claude Code releases and flag features worth adopting into the workflow.

## Reporting
- **`/product-status`** — Consolidated health check across the product portfolio.
- **`/weekly-update`** — Draft the recurring leadership update from current product state.

The pair that makes this compound: `/learn` captures, `/evolve` promotes. Everything else is built on top.
