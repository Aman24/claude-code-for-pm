# claude-code-for-pm

**How one PM runs a multi-product portfolio on Claude Code.**

This repo publishes the operating model I use — the rules, contexts, commands, agents, hooks, and skills that shape Claude Code into a thinking partner across a real portfolio. Not a tutorial. Not a vendor product. Working artefacts a PM can copy into their own `.claude/` and start using.

## Who this is for

PMs (not engineers) who already know Claude Code exists and want a working operating model — not another article on prompting. If you're running multiple products and want Claude to behave like a senior partner across them instead of a one-shot autocomplete, the patterns here will compound.

## What this is

A working PM operating model. Here's what's in the repo today, and what's landing next:

| Layer | What it does | Status |
|---|---|---|
| **`CLAUDE.md.template`** | The harness. Sets role, north star, product map, how-we-work for one PM running a portfolio. | **Live** |
| **`rules/`** | Behavioural rules Claude follows every session — confidence tagging, strategic lens, operating discipline. | **Live** · 3 rules |
| **`contexts/`** | Four operating modes — Strategy / Execution / Review / Analyse — switched per task. | **Live** · 4 modes |
| **`commands/`** | Slash commands that codify the workflow — session start, mode switching, the `/learn` → `/evolve` memory loop, automation, and reporting. | **Live** · 8 commands |
| **`templates/`** | Spec template for non-trivial builds. | **Live** · 1 |
| **`agents/`** | Specialised subagents for repeatable work (exec updates, risk scans, prompt tuning). | **Coming next** |
| **`hooks/`** | Safety + automation layer — pre-bash guards, write guards, secret scans, pre-compact saves. | **Planned** |
| **`skills/`** | A small curated set of PM skills I've built and use. ~12 sanitized originals. | **Planned** |

*Live* = in the repo now · *Coming next* = the next weekly drop · *Planned* = on the roadmap.

## How to use it

1. Copy `CLAUDE.md.template` to your project root as `CLAUDE.md`. Fill in your own product map, key dates, and goals.
2. Copy `rules/`, `contexts/`, `commands/`, `templates/` into `.claude/` in your project (or your user dotfiles).
3. Run a session. The first command to try: `/context strategy` for a high-altitude session, or `/context execution` for hands-on work.
4. After a non-trivial session, run `/learn` to capture what worked into a memory file.

The artefacts are designed to be read in order: `CLAUDE.md.template` → `rules/` → `contexts/` → `commands/`. The whole tree is well under 1,000 lines.

## What this isn't

- **Not a tutorial.** The README is short on purpose. The files are the documentation.
- **Not opinionated about your stack** — works whether you're using Claude Code, Codex, or anything that reads a CLAUDE.md harness and slash commands.

## Sibling repo

[`AI-agent-as-product`](https://github.com/Aman24/AI-agent-as-product) — about *building* AI agent products. This repo is about *working with* one.

## Cadence

Weekly drops. The foundation landed first — harness template, rules, contexts, and the core commands. Each drop layers in another subsystem (agents next, then hooks, then skills). See the commit history for what's shipped.

## Licence

MIT. Take it, fork it, adapt it. If you build a better version, I'd like to read it — link your fork in an issue.

## Contributing

PRs welcome on **operating-model patterns** (rules, contexts, command protocols, harness shapes). Skills stay personal — fork and build your own.
