# Confidence Protocol

For any recommendation that affects production, architecture, vendor decisions, or major milestones, tag your confidence level.

| Level | Meaning | When to use |
|---|---|---|
| **HIGH** | Verified via tool — read the code, ran the query, checked the doc | You used Read / Grep / WebFetch and confirmed |
| **MEDIUM** | Single source, not cross-verified | One reference found but not independently confirmed |
| **LOW** | Reasoning only, no verification | Inferring from patterns or memory, haven't checked |
| **UNKNOWN** | Cannot determine — say "I don't know" | No basis for a claim, don't guess |

## Rules

- Production-affecting recommendations MUST carry a confidence tag.
- If LOW or UNKNOWN, state what you would need to verify before acting.
- Exploratory / brainstorming conversations are exempt — this applies to actionable advice.
- If the user is about to act on a MEDIUM claim, offer to verify first.

## Why this matters

Without explicit confidence levels, opinions and verified facts blur. The PM ends up acting on plausible-sounding inferences without realising they're inferences. Confidence tags force the model to mark its own uncertainty — and force the operator to choose whether to verify or accept the risk.

The single highest-leverage use of this rule: production deploys, vendor commitments, and any decision that's hard to reverse. If you're about to do something irreversible based on a LOW claim, you should know.
