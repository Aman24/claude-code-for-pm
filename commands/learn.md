# /learn — Capture Session Wins into Persistent Memory

After solving a non-trivial problem or discovering a useful pattern, run this command to extract and persist the learning so it compounds across sessions.

## Steps

1. **Identify what was learned.** Ask: *What did we solve, discover, or confirm this session?*
   - Bug-resolution patterns
   - Vendor / partner behaviour patterns
   - Product gotchas (data quirks, edge cases, environment differences)
   - Workflow shortcuts
   - Decision rationale that's likely to recur

2. **Classify the learning.** Determine where it belongs:

| Type | Target File |
|---|---|
| Product-specific insight | `memory/product-intelligence.md` |
| Vendor / people pattern | `memory/vendor-map.md` or `memory/people-directory.md` |
| Workflow improvement | `memory/workflow-patterns.md` |
| Operating principle | `memory/operating-principles.md` |
| Completed deliverable | `memory/completed-deliverables.md` |
| New reusable pattern | New file in `memory/` + link from `MEMORY.md` index |

   (The memory tree is yours to design. The point is: every type of learning has a known home, so nothing gets lost.)

3. **Check for duplicates.** Read the target memory file first. If the learning already exists, update it with new context rather than duplicating.

4. **Write the learning** with:
   - Date of discovery
   - Context (which product, what task)
   - The pattern / insight itself
   - **Why it matters** — so future sessions understand the weight

5. **Update the index.** If a new memory file was created, link it from `MEMORY.md`. If an existing section was significantly updated, note the update date.

6. **Confirm.** Summarise what was captured and where.

## Rules

- Only capture confirmed patterns, not speculative insights. "I think this might be a pattern" doesn't belong in persistent memory.
- Keep entries concise — 2-3 lines per learning. Compression aids recall.
- If the learning contradicts an existing memory entry, **update the old one** — don't keep both.
- Never capture credentials, secrets, or anything that fingerprints a specific person, vendor, or sensitive context.
- Capture from success AND failure. If a non-obvious approach worked, that's as worth recording as a correction.

## Why this matters

The compounding value of working with an AI partner comes from memory. Without `/learn` (or its equivalent), every session starts cold and the same gotchas get rediscovered every quarter. With it, the system gets sharper every week — the operator's actual edge.
