# /session-start — Standard Session Protocol

Initialize a working session with proper context loading. Run at the top of any non-trivial session.

## Steps

1. Ask the operator: **Which product are we working on today? What's the goal?**
2. Read the relevant `products/<product>/CLAUDE.md` for sharp-edge context.
3. Check `docs/decisions/` for any recent ADRs affecting this product.
4. Check the guardrails file (`.claude/hooks/guardrails.md` or equivalent) for active constraints.
5. Summarise: product status, last known state, any open blockers or risks.
6. Confirm the working scope before proceeding.

## Context to always load

- Root `CLAUDE.md` (loaded automatically by Claude Code).
- The specific product's `products/<product>/CLAUDE.md`.
- Any related skill if the goal maps to one — invoke it explicitly so the operator sees which playbook is active.

## Rules

- Never start working on a product without reading its context file first. Stale assumptions are how you build the wrong thing.
- If the product context seems stale (>2 weeks since last update), flag it before relying on it.
- If the goal spans multiple products, invoke the `cross-product-update` skill (or its equivalent) — cross-product reasoning is a different mode of work.
- Surface the operating mode that should be active. Default-ask `/context` if it's ambiguous.

## What this command isn't

This isn't a status report. It's a *load* step — the goal is to get Claude into the right context before any real work starts. Treat it like opening the file you're going to edit, not like reading the changelog.
