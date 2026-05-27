# /product-status — Cross-Product Status Check

Run a quick status check across all products in the portfolio.

## Steps

1. Launch the `product-analyst` agent to read all `products/*/CLAUDE.md` files
2. For each product, extract: current status, last update, next milestone, any blockers
3. Present a consolidated status table
4. Flag any product that hasn't been updated in >2 weeks
5. Highlight any cross-product dependencies or conflicts

## Output format

| Product | Status | Health | Next Milestone | Blocker? |
|---|---|---|---|---|

Health: GREEN (on track) / YELLOW (needs attention) / RED (blocked)

Follow with a brief narrative: what's going well, what needs attention, what's the #1 risk right now.
