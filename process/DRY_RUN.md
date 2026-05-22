# Dry-run record (LabAppDemo)

Validated 2026-05-22.

## Command

```bash
./scripts/new-app.sh LabAppDemo macos
./scripts/sync-status.sh ../LabAppDemo
```

## Handoffs exercised

| Step | Artifact |
|------|----------|
| Scaffold | `../LabAppDemo/` + initial git commit |
| Kickoff | `docs/KICKOFF.md` |
| Spec | `docs/PRD.md`, `docs/BACKLOG.md` P0-1 |
| UX | `docs/SCREENS.md` |
| Content | `docs/COPY.md` |
| Architecture | `docs/ARCHITECTURE.md` |
| Engineer | `ContentView.swift` tagline + P0-1 checked |
| QA | `docs/QA.md` |
| Director | `docs/STATUS.md` |

## Result

- `swift build` passes in `LabAppDemo`.
- Sibling path: `/Users/yuno/Documents/Github/LabAppDemo` (outside Lab App meta-repo).

Delete `LabAppDemo` when no longer needed.
