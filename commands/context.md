# /context — Switch Operating Mode

Set the session's operating mode to align behaviour with the task type. The four modes shape how Claude works — what it pushes back on, what it accepts, what skills it invokes.

## Usage

Tell Claude which mode to activate:

- `/context strategy` — Vision, positioning, market analysis, long-term planning
- `/context execution` — Hands-on delivery, writing, building, shipping
- `/context review` — Critical evaluation, stress-testing, risk assessment
- `/context analyse` — Research, data deep-dives, competitor teardowns

## Steps

1. Read the requested context file from `contexts/<mode>.md`.
2. Acknowledge the mode switch with a one-line confirmation.
3. Adjust behaviour per the context file's instructions for the rest of the session.
4. If no mode is specified, ask: *"What type of work are we doing? Strategy, Execution, Review, or Analysis?"*

## Rules

- Mode persists for the entire session unless explicitly switched.
- Modes can be combined when the operator requests them — e.g. "strategy then review", which means do strategic exploration first, then stress-test the output.
- Default to asking if the task doesn't clearly map to one mode. Wrong mode = subtly wrong work.
- Always load the product `CLAUDE.md` regardless of mode.

## Why modes matter

A strategy session and an execution session need different defaults. In strategy, Claude should push back, expand scope, surface alternatives. In execution, Claude should lock scope, minimise interruptions, ship. The same model can do both — but only if it knows which one is being asked for.

Without explicit modes, sessions default to a kind of middle behaviour that's never quite right for any task. The friction of stating the mode up front is paid back many times over by the session's output quality.
