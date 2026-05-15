# Sanitization Rules

The artefacts in this repo are sanitized versions of what I actually use day-to-day at a large multi-product organisation. This file documents what stays in, what stays out, and why — so anyone forking can apply the same hygiene to their own version.

## What stays out, always

- **Employer, organisation, brand names** — including parent brand, sub-brand, internal codenames
- **Product names** — internal-only product names and customer-facing ones
- **Person names** — colleagues, vendors, leadership, advisors
- **Vendor names** — referred to by category instead (e.g. "a third-party WhatsApp BSP", not the BSP's name)
- **Specific dates** — use relative time (`T-6 months`, `Q+1`, "first half of next year")
- **Financial figures** — qualitative bands or ranges only
- **Internal URLs** — staging environments, S3 buckets, internal dashboards, bug sheets, requirement docs
- **Sample data** — even illustrative tables shouldn't contain anything that could be traced back

## What's OK

- **Generic tool names** — Claude Code, GitHub, Figma, etc. (used as nouns, never as personal attribution)
- **Generic categories** — "BSP", "OTT platform", "CMS", "centre network"
- **Time horizons** — "next decade", "Q4", "EOY"
- **Quantitative shapes without specifics** — "12-initiative portfolio", "350+ centres", "100K+ active users"
- **Tonal phrases** — only if they don't fingerprint the source

## The two-question test

Before publishing any file, ask:

1. **Could this embarrass anyone?** A colleague, a vendor, leadership, the organisation, myself.
2. **Could this hand a competitor an advantage?** Strategic moves, pricing logic, internal capacity, vendor weaknesses, roadmap.

If the answer to either is "yes" or "maybe" — sanitize harder or cut.

## When in doubt

- **Generalise the pattern, drop the example.** A framework is reusable; the example that illustrates it is the disclosure.
- **Aggregate.** "Several products" beats "five products"; "a multi-product cycle" beats "the Q3 release cycle".
- **Move time-sensitive material to past tense.** A pattern that worked is less risky than a plan in flight.
- **Diff the public version against the source.** If you can recover the original by reading the public copy, it's not sanitized enough.

## What this repo deliberately doesn't include

- Live decision logs from the source organisation (general patterns only)
- Skills tied to a single product or vendor relationship (generalised or cut)
- Hooks that reference specific repo paths (rewritten to be path-agnostic)
- Memory files (those are personal and contain identifying patterns by design)

The point of publishing isn't to share the *content* of my work — it's to share the *shape* of the system. The shape generalises. The content stays mine.
