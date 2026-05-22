# Role handoffs by phase

| Phase | Role | Reads | Produces |
|-------|------|-------|----------|
| 1 | Director | Intake notes | `docs/KICKOFF.md`, initial `docs/STATUS.md` |
| 2 | Product Spec | `KICKOFF.md`, `PRD.md` draft | `docs/PRD.md`, `docs/BACKLOG.md` (P0) |
| 3 | UX (ios/macos) | P0 tickets | `docs/SCREENS.md`, ticket UX notes |
| 3 | Brand + Content | `SCREENS.md`, `KICKOFF.md` | `docs/COPY.md` |
| 4 | Architect | `BACKLOG.md`, `SCREENS.md` | `docs/ARCHITECTURE.md`, ADRs if needed |
| 5 | Engineer | `ARCHITECTURE.md` | Green build, `STATUS.md` → phase 6 |
| 6 | Engineer | One P0 ticket + UX + arch | Code, checked ticket, build note in `STATUS.md` |
| 6 | Director | Engineer output | Updated `STATUS.md`, next ticket |
| 7 | QA | Closed P0, `COPY.md` | `docs/QA.md` filled |

## Per-ticket engineering handoff

Before coding a P0 ticket, Engineer confirms:

- [ ] Acceptance criteria copied or referenced in implementation notes
- [ ] `docs/SCREENS.md` covers this flow (or ticket includes UX snippet)
- [ ] `docs/ARCHITECTURE.md` does not block the approach
- [ ] `docs/COPY.md` has strings if user-visible text changes

After coding:

- [ ] Ticket checkbox marked in `BACKLOG.md`
- [ ] `STATUS.md` updated: what changed, next action, blockers

## Director decision log

Append brief bullets under **Decision log** in `STATUS.md` when scope or guardrails change.
