# claude-code-for-pm

**How one PM runs a multi-product portfolio on Claude Code.**

This repo publishes the operating model I use — the rules, contexts, commands, agents, hooks, and skills that shape Claude Code into a thinking partner across a real portfolio. Not a tutorial. Not a vendor product. Working artefacts a PM can copy into their own `.claude/` and start using.

## Who this is for

PMs (not engineers) who already know Claude Code exists and want a working operating model — not another article on prompting. If you're running multiple products and want Claude to behave like a senior partner across them instead of a one-shot autocomplete, the patterns here will compound.

## What this is

A working PM operating model with five layers:

| Layer | What it does | Status |
|---|---|---|
| **`CLAUDE.md.template`** | The harness. Sets role, north star, product map, how-we-work for one PM running a portfolio. | v0 |
| **`rules/`** | Behavioural rules Claude follows every session — confidence tagging, strategic lens, operating discipline. | v0 |
| **`contexts/`** | Four operating modes — Strategy / Execution / Review / Analyse — switched per task. | v0 |
| **`commands/`** | Slash commands that codify session protocols — `/session-start`, `/context`, `/learn`. More each week. | v0 |
| **`agents/`** | Specialised subagents for repeatable work (exec updates, risk scans, prompt tuning). | shipping Week 3 |
| **`hooks/`** | Safety + automation layer — pre-bash guards, write guards, secret scans, pre-compact saves. | shipping Week 4 |
| **`skills/`** | A small curated set of PM skills I've built and use. ~12 sanitized originals. | shipping Weeks 5-7 |
| **`templates/`** | Spec template (v0). Weekly-update template (week 5). | v0 |

## How to use it

1. Copy `CLAUDE.md.template` to your project root as `CLAUDE.md`. Fill in your own product map, key dates, and goals.
2. Copy `rules/`, `contexts/`, `commands/`, `templates/` into `.claude/` in your project (or your user dotfiles).
3. Run a session. The first command to try: `/context strategy` for a high-altitude session, or `/context execution` for hands-on work.
4. After a non-trivial session, run `/learn` to capture what worked into a memory file.

The artefacts are designed to be read in order: `CLAUDE.md.template` → `rules/` → `contexts/` → `commands/`. The whole tree under 1,000 lines on v0.

## What this isn't

- **Not a skill catalog.** For breadth, look at [`phuryn/pm-skills`](https://github.com/phuryn/pm-skills) (62 skills, MIT-licensed, much wider).
- **Not a vendor product.** For dev-Claude-Code at scale, see [ecc.tools](https://ecc.tools).
- **Not a tutorial.** The README is short on purpose. The files are the documentation.
- **Not opinionated about your stack** — works whether you're using Claude Code, Codex, or anything that reads a CLAUDE.md harness and slash commands.

## Sibling repo

[`AI-agent-as-product`](https://github.com/Aman24/AI-agent-as-product) — about *building* AI agent products. This repo is about *working with* one.

## Cadence

Weekly drops. v0 ships the foundation (rules + contexts + first 3 commands + harness template). Each week through Week 8 layers in another subsystem. See commit history for what's landed.

## Licence

MIT. Take it, fork it, adapt it. If you build a better version, I'd like to read it — link your fork in an issue.

## Contributing

PRs welcome on **operating-model patterns** (rules, contexts, command protocols, harness shapes). Skills stay personal — fork and build your own.
