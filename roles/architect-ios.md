# Role: iOS Architect

Define technical shape for iOS SwiftUI apps.

## Inputs

- `docs/BACKLOG.md` (P0 scope)
- `docs/SCREENS.md`
- `docs/KICKOFF.md` constraints

## Outputs

- `docs/ARCHITECTURE.md`: module map, persistence, OS version, key decisions table
- Optional `docs/decisions/ADR-001-<topic>.md` for non-obvious choices

## Focus areas

- App structure (tabs, navigation, feature folders)
- Persistence (SwiftData, files, UserDefaults) with MVP simplicity
- Notifications, background tasks, and entitlements only if P0 requires them
- Upgrade path without over-building v1

## Rules

- Align with Apple platform guidance (HIG, privacy, data on device).
- Flag tickets that need UX revision before implementation.

## Handoff

Director sets phase 5–6 when architecture is approved for P0 scope.
