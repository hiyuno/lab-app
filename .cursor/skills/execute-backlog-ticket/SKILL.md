---
name: execute-backlog-ticket
description: >-
  Implements one P0 backlog ticket for iOS/macOS apps with handoff checks (SCREENS,
  COPY, ARCHITECTURE) and updates BACKLOG and STATUS. Use when shipping a ticket,
  closing P0-1, or engineering a single backlog item.
---

# Execute backlog ticket

## Before code

1. Read `docs/STATUS.md`, `docs/KICKOFF.md`, [roles/engineer.md](../../roles/engineer.md).
2. Select **one** open P0 ticket in `docs/BACKLOG.md`.
3. Confirm handoffs:
   - [ ] Acceptance criteria listed
   - [ ] `docs/SCREENS.md` covers flow (or ticket has UX notes)
   - [ ] `docs/ARCHITECTURE.md` allows approach
   - [ ] `docs/COPY.md` has strings if UI text changes

If anything missing, stop and ask Director to run the missing role first.

## Implementation

- Minimal diff; match project conventions.
- iOS: verify Xcode build when possible.
- macOS SwiftPM: `swift build` from app root.

## After code

1. Mark ticket checkbox in `docs/BACKLOG.md`.
2. Update `docs/STATUS.md` last session + next action.
3. Note build command and result in STATUS.

## Do not

- Implement multiple P0 tickets in one session unless Director explicitly batches.
- Change `KICKOFF.md` guardrails without Director decision log entry.
