# /loop — Recurring Automated Tasks

Set up Claude to run a prompt or command on a recurring interval within a session.
Uses Claude Code's native /loop feature.

## PM Use Cases

### 1. Product Health Monitor
```
/loop 30m Run /product-status and flag any product with new blockers or stale context (>14 days)
```

### 2. Anchor-Event Countdown
```
/loop 1h Check weeks remaining to the anchor event, scan products/ for any RED status items
```

### 3. Vendor Response Tracker
```
/loop 2h Check if any vendor deliverables are overdue per the vendor memory file, flag for follow-up
```

### 4. Pre-Meeting Prep
```
/loop 1d If the recurring leadership meeting is tomorrow, run /weekly-update to prep the materials
```

### 5. Post-Launch Monitor
```
/loop 15m Check [product URL] for uptime, scan for errors, report any issues
```

## How to Use

Simply type in Claude Code:
```
/loop <interval> <prompt or command>
```

Intervals: `5m`, `15m`, `30m`, `1h`, `2h`, `1d`

## Rules
- Only run loops for tasks with clear stop conditions or session boundaries
- Don't loop destructive operations
- Always pair with a monitoring goal — loops without purpose waste tokens
- For persistent automation beyond a session, use headless mode (`claude -p`) with cron instead
