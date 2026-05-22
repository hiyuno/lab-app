# App creation phases

| Phase | Name | Primary artifacts | Typical owner |
|-------|------|-------------------|---------------|
| 0 | Intake | `intake.md` (scratch or Lab App notes) | Human |
| 1 | Kickoff | `docs/KICKOFF.md` | Director |
| 2 | Spec | `docs/PRD.md`, `docs/BACKLOG.md` (P0) | Product Spec |
| 3 | Design | `docs/SCREENS.md`, `docs/COPY.md` | UX + Content |
| 4 | Architecture | `docs/ARCHITECTURE.md` | Architect |
| 5 | Scaffold | Repo + green build | Engineer + `new-app.sh` |
| 6 | Build loops | Closed P0 tickets | Engineer (batched) |
| 7 | Alpha | `docs/QA.md`, P1 backlog | QA + Director |
| 8 | App Store | `docs/APPSTORE_AUDIT.md`, `docs/APPSTORE_CHECKLIST.md` | App Store release (iOS) |

## Phase details

### 0 — Intake
Capture idea, constraints, stack (`ios` or `macos`), and non-goals. No code required.

### 1 — Kickoff
Fill `KICKOFF.md`: objective, guardrails, current state, next steps, milestone definition of done.

### 2 — Spec
Short `PRD.md` plus `BACKLOG.md` with P0 tickets. Every P0 ticket needs acceptance criteria.

### 3 — Design
Batch A style (see Goals `DAY1_EXECUTION`): finalize P0 criteria, screen flows, copy for empty states and primary CTAs.

### 4 — Architecture
Module boundaries, persistence, and upgrade paths. Keep MVP simple.

### 5 — Scaffold
Run `./scripts/new-app.sh <Name> <ios|macos>`. Engineer confirms Xcode or `swift build` succeeds.

### 6 — Build loops
Director assigns one P0 at a time. Engineer implements, updates backlog, Director updates `STATUS.md`.

### 7 — Alpha
Dogfood with `docs/QA.md`. Log follow-ups as P1.

## Batched execution (example)

**Batch A:** Spec + UX + Copy on the same P0 set.  
**Batch B:** Engineering implementation.  
**Batch C:** QA review and P1 triage.

### 8 — App Store (iOS only)

1. Run `apple-app-review` full audit → `docs/APPSTORE_AUDIT.md`.
2. Fix P0 findings (phase 6 loops).
3. Complete `docs/APPSTORE_CHECKLIST.md`.
4. Optional: `app-store-connect` with API credentials for upload/submit.

See [APPSTORE_AGENTS.md](APPSTORE_AGENTS.md).

## Future (v2)

- Web stacks branch in templates
- CI, Mac notarization (non-iOS)
- `fastlane` standardization alongside ASC skill

## PR hygiene

When opening pull requests from app repos, use global skills such as `split-to-prs` where changes are large.
