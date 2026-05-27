# /evolve — Promote Patterns into Reusable Infrastructure

Periodically review accumulated learnings in memory files and promote recurring patterns
into higher-order structures: commands, skills, agents, or guardrails.

## Steps

1. **Scan memory files** — Read all files in `memory/`:
   - `operating-principles.md` — recurring workflow rules
   - `workflow-patterns.md` — repeated process patterns
   - `product-intelligence.md` — product-specific patterns
   - `completed-deliverables.md` — delivery patterns

2. **Identify promotion candidates** — Look for:
   - **3+ similar entries** → candidate for a new skill or command
   - **Repeated guard/check patterns** → candidate for a guardrails addition
   - **Recurring multi-step workflows** → candidate for a new command
   - **Domain-specific expertise patterns** → candidate for a new skill
   - **Complex delegation patterns** → candidate for a new agent

3. **Propose promotions** — Present to user:
   ```
   PROMOTION CANDIDATES:
   1. [Pattern] → Promote to: [skill/command/agent/guardrail]
      Evidence: [which memory entries, how many times observed]
      Proposed name: [name]
   ```

4. **On user approval, create the asset**:
   - **Command** → `.claude/commands/<name>.md`
   - **Skill** → `.claude/skills/<name>/SKILL.md`
   - **Agent** → `.claude/agents/<name>.md`
   - **Guardrail** → Append to `.claude/hooks/guardrails.md`

5. **Clean up source** — Remove or condense the original memory entries that were
   promoted (they now live as infrastructure, not memory).

6. **Update registry** — If a skill was created, add it to the skills registry.
   If a command was created, note it in the CLAUDE.md folder map.

## Rules
- Never auto-promote without user approval — always present candidates first
- Minimum evidence: 3 observations or explicit user request
- Promoted assets must follow existing format conventions (check siblings)
- This is a periodic hygiene task, not a daily one — run monthly or when memory files feel heavy
