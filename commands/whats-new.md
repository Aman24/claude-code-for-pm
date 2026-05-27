# /whats-new — Claude Code Feature Tracker

Scan recent Claude Code releases and flag features that can enhance the PM workflow.

## Steps

1. **Fetch changelog** — WebFetch https://code.claude.com/docs/en/changelog
   Extract features from the last 30 days.

2. **Filter for PM-relevant features** — Score each against:
   - Does it enable more automation? (hooks, headless, /loop, background agents)
   - Does it improve a multi-product workflow? (agents, worktrees, sessions)
   - Does it enhance the memory/context system? (compaction, memory, CLAUDE.md)
   - Does it add new integration points? (MCP, plugins, SDK)
   - Does it improve the operating modes? (commands, skills, voice)

3. **Compare against the current setup** — Check what's already in use vs what's new:
   - Read `.claude/settings.json` for current hooks/permissions
   - Read CLAUDE.md for current workflow
   - Read the model-routing doc for model config
   - Read the workflow-patterns memory file for known patterns

4. **Present findings** — Format as:
   ```
   NEW FEATURES RELEVANT TO US:

   HIGH IMPACT (adopt now)
   - [Feature] — What it does → How it helps the workflow → Action to adopt

   MEDIUM IMPACT (adopt when convenient)
   - [Feature] — What it does → How it helps → Action

   LOW IMPACT (awareness only)
   - [Feature] — What it does
   ```

5. **On user approval** — Implement the adopted features:
   - Update `settings.json` for new hooks/permissions
   - Create new commands/skills if needed
   - Update CLAUDE.md if the workflow changes
   - Update the workflow-patterns memory file with new patterns
   - Log a decision record if it's a significant adoption

## Rules
- Run this monthly or when the user asks
- Don't adopt anything without user approval
- Focus on PM workflow, not engineering-only features
- Always check if a feature replaces something built custom (prefer native over custom)
