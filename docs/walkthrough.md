# A day in this operating model

What it looks like in practice — a ~25-minute session that ties the rules, contexts, commands, and harness together. Lightly sanitized from a real session.

## The setup

A PM running a multi-product portfolio needs to make a build-vs-buy call on a new admin dashboard. Decision is due end of the week. The product is the org's main customer-facing app; the dashboard is internal-only. Stakes are moderate — but the call will set a precedent for similar decisions across the portfolio.

The PM opens Claude Code.

## The session

**Operator:** `/session-start`

**Claude:** *(reads the root `CLAUDE.md`, then `products/customer-app/CLAUDE.md`, scans `docs/decisions/` and `tasks/todo.md`)*

> Status check on Customer App:
> - Live since T-5 months, stable
> - Phase 2 planning starts next sprint
> - No prior build-vs-buy ADR in the repo
> - Open blocker: backend team capacity question (flagged ~2 weeks ago, no movement)
>
> The capacity question is going to bear on this decision. Want me to surface it explicitly when we get to trade-offs, or have you already heard back?

**Operator:** Haven't heard back. Flag it. Let's go — `/context strategy`

**Claude:** Strategy mode active. Pushing every option one altitude higher than tactical. Cross-product implications surfaced by default.

> Three real options for the admin dashboard:
>
> 1. **Build in-house** — full control, ~4-6 weeks of backend capacity, integrates cleanly with existing auth.
> 2. **Buy a SaaS admin tool** — ~1-week setup, recurring per-seat cost, adds two more vendor relationships to manage.
> 3. **Hybrid: vendor for v1, build for v2** — fastest to ship, lock-in risk, possibly the worst long-run cost.
>
> Before we pick: option 1 is gated on the backend capacity question that's been open ~2 weeks. We can't pick build without resolving that first. *(**HIGH** — verified the open blocker in tasks/todo.md.)*

**Operator:** Right. So really the choice is buy v1 then maybe build v2.

**Claude:**

> That collapses the decision but it might be the wrong collapse. Strategic-lens check:
>
> 1. Does it serve the unified user journey? — Admin dashboard is internal; both options score the same.
> 2. Does it connect to the platform? — Buy = a new fragment, separate UI, separate auth. Build = native. **Build wins here.**
> 3. Does it scale to the next milestone? — Either option scales; volume is low.
> 4. Does it honour the brand promise? — Internal-only, less relevant.
> 5. Does it bridge the core product to its ecosystem? — Neither option strongly does.
>
> Build wins one question; buy loses one; the hybrid trades both. The backend capacity blocker is the real fulcrum.
>
> **Pushback:** don't pick the hybrid by default just because the build path is blocked. That's choosing under duress. Resolve the capacity question first; the decision may invert.

**Operator:** Fair. Will get the capacity answer tomorrow. Meantime let me capture the framing.

**Operator:** `/learn`

**Claude:** *(asks what we discovered this session, then writes to memory)*

> Captured to `memory/workflow-patterns.md`:
>
> **Build-vs-buy under a capacity gate.** When a build path is blocked by an unresolved capacity question, the default move is to drift toward buy. Stop and check whether the gate can be resolved in time — picking under duress is how organisations accumulate vendor relationships they don't actually want. Strategic-lens Q2 ("connect to the platform") is usually the deciding factor when other stakes are low.
>
> *Why it matters: this pattern will recur. Every team has a capacity bottleneck. Every team has buy options that look easier. The discipline is testing whether the gate is real before letting it dictate the call.*

**Operator:** Good. Out.

## What this session did

- **Loaded context** without the operator having to brief Claude on the product
- **Made the open blocker visible** before it could quietly bias the decision
- **Forced a strategic-lens pass** instead of jumping to the obvious answer
- **Pushed back** on a decision collapsing under time pressure
- **Captured the pattern** so the next build-vs-buy session starts ahead of where this one did

The whole thing took ~25 minutes. Nothing here is magic. The harness, the rules, and the commands just remove the friction of remembering to do these things every time.

## Where each file showed up

| Moment in the session | File doing the work |
|---|---|
| Initial product status read | `CLAUDE.md.template` (defines what gets loaded on session-start) |
| Open blocker surfaced | `rules/operating-rules.md` ("confirm scope before data changes", "no bloat") |
| Confidence tag on the blocker claim | `rules/confidence-protocol.md` |
| Strategic-lens five-question pass | `rules/strategic-lens.md` |
| Pushback on the hybrid | `contexts/strategy.md` ("bidirectional challenge", "don't accept good-enough") |
| Pattern captured to memory | `commands/learn.md` |

Read those files in that order if you want to see how the surface area connects.

## How to try it

1. Copy the v0 tree into the `.claude/` folder of a project you actually work on.
2. Run a real session on a real decision (not a toy one — toy sessions teach toy lessons).
3. Use `/session-start`, then `/context strategy` (or execution / review / analyse depending on what you're doing).
4. After anything non-trivial, run `/learn` and write the pattern to a memory file.

Don't worry about matching this transcript word-for-word. The system bends to the operator's voice. The point is the *discipline* of having a system at all — not the specific words it produces.
