---
name: director-orchestrate
description: >-
  Orchestrates iOS/macOS app work as Director (PM + Tech Lead): reads STATUS and
  KICKOFF, assigns one role per step, enforces handoff order, updates STATUS. Use when
  coordinating agents, planning sprints, or when the user asks for Director or PM.
---

# Director orchestrate

## Load context

1. [roles/director.md](../../roles/director.md)
2. App repo: `docs/STATUS.md`, then `docs/KICKOFF.md`
3. [AGENTS.md](../../AGENTS.md) handoff protocol
4. [process/HANDOFFS.md](../../process/HANDOFFS.md) for phase I/O

## Pick exactly one next action

| Phase | Assign to | Output |
|-------|-----------|--------|
| 1-kickoff | Director + human | `KICKOFF.md` complete |
| 2-spec | Product Spec | `PRD.md`, P0 in `BACKLOG.md` |
| 3-design | UX (ios/macos) + Brand | `SCREENS.md`, `COPY.md` |
| 4-architecture | Architect (ios/macos) | `ARCHITECTURE.md` |
| 5-scaffold | Engineer | Green build |
| 6-build | Engineer | One P0 ticket closed |
| 7-alpha | QA | `QA.md` |

Update `docs/STATUS.md`: **Phase**, **Active role**, **Next action**, **Handoff queue** table.

## Subagent use

- **explore** — readonly codebase discovery
- **generalPurpose** — single P0 implementation with `roles/engineer.md`
- **shell** — `swift build`, git, xcodebuild

Parent owns `STATUS.md` and backlog priority. Never run two roles that edit the same files in parallel.

## Stop and escalate when

- Missing acceptance criteria on active P0
- Guardrail conflict with `KICKOFF.md`
- Signing, entitlements, or Apple account blockers

## Session end template (STATUS.md)

```markdown
**Last session:** <date> — <role> completed <artifact>; <build status>.
**Next action:** <single imperative>.
```
