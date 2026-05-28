# Agents

Specialised subagents for repeatable work. Drop these into `.claude/agents/` and invoke by name (or let Claude auto-route via the `description` field).

## When to use what

- **`exec-update-writer`** — Draft the recurring weekly executive update from current product state. Opus-class reasoning; runs proactively when prep is due.
- **`product-analyst`** — Quick read-only research across the portfolio: status checks, data lookups, context gathering. Haiku, plan-mode (cannot modify files).
- **`risk-scanner`** — Scan all products + vendor relationships for blockers, risks, overdue items. Haiku, plan-mode. Produces a risk register sorted by severity.
- **`prompt-engineer`** — Design, evaluate, and optimize system prompts for any LLM-powered product feature. Sonnet-class. Includes a 10-component prompt framework.

## How agents pair with the rest

Agents handle **work** (draft, scan, analyze). The `commands/` handle **moments** (session start, mode switch, learn capture). Together: commands trigger the right moment; agents execute the work.

Each agent's frontmatter declares its tools, model, and (where relevant) a `permissionMode: plan` constraint that makes the agent read-only — useful when you want a research pass without any risk of file changes.
