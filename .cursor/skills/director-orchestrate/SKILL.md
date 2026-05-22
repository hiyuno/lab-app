---
name: director-orchestrate
description: >-
  Orchestrates iOS/macOS app work as Director: reads STATUS, SKILLS registry, assigns
  roles and named Cursor skills per phase, spawns subagents with skill+role prompts,
  updates STATUS. Use when user says Director, orchestrator, PM, or start/continue the process.
---

# Director orchestrate

You are the **Orchestrator**. Skills live in **`.cursor/skills/`** (Cursor), **`.claude/skills/`** (Claude Code), or **`.agents/skills/`** (Antigravity) — same names after `install-agents.sh` or `sync-project-skills.sh`. See `process/PLATFORMS.md`.

## Phase 0 — Intake first (new apps)

If `docs/INTAKE.md` has empty **Platform** or **App idea**, or there is no `docs/STATUS.md` yet:

1. **Do not** discuss lab-app cloning, GitHub, or `new-app.sh` errors.
2. Ask the user **only**:
   - **Q1:** Platform — **iOS**, **macOS**, or **both**? (If both: default scaffold iOS first unless they say otherwise.)
   - **Q2:** **App idea** — what is it, for whom, what problem?
3. Save answers in `docs/INTAKE.md`.
4. Run `../Lab App/scripts/new-app.sh <AppName> ios|macos` from Lab App (intake-only folders are supported).
5. Copy intake into `docs/KICKOFF.md`, then continue at phase 1.

Full script: [process/INTAKE.md](../../process/INTAKE.md).

## Mandatory reads (after intake / existing apps)

1. `docs/STATUS.md` (if missing, you are in phase 0)
2. `docs/KICKOFF.md`
3. `docs/SKILLS.md` (short map)
4. [process/SKILLS_REGISTRY.md](../../process/SKILLS_REGISTRY.md) (full skill catalog)
5. [roles/director.md](../../roles/director.md)
6. [AGENTS.md](../../AGENTS.md) handoff order

If `process/SKILLS_REGISTRY.md` is missing, run `scripts/sync-project-skills.sh` from Lab App on this repo.

## Phase → role → primary skill

| Phase | Role file | Primary skill(s) | Output |
|-------|-----------|------------------|--------|
| 1-kickoff | `director.md` | — | `KICKOFF.md` |
| 2-spec | `product-spec.md` | — | `PRD.md`, `BACKLOG.md` |
| 3-design | `ux-ios.md` / `ux-macos.md` | `ui-ux-pro-max`, then `design-with-claude`, optional `libre-uiux` | `SCREENS.md`, `COPY.md` |
| 4-architecture | `architect-ios.md` / `architect-macos.md` | `ios-dev-guide` (iOS), `swiftdata-pro` if persistence | `ARCHITECTURE.md` |
| 5-scaffold | `engineer.md` | `new-app` (Lab App only) | green build |
| 6-build | `engineer.md` | `execute-backlog-ticket` + ticket skill below | P0 closed |
| 7-alpha | `engineer.md` / QA | — | `QA.md` |
| 8-appstore | `appstore-release.md` | `app-store-release` → `apple-app-review` | `APPSTORE_AUDIT.md`, `APPSTORE_CHECKLIST.md` |

### Phase 6 — pick by ticket (one skill)

| Ticket needs | Skill |
|--------------|-------|
| SwiftUI screens | `swiftui-pro` |
| async / concurrency | `swift-concurrency-pro` |
| SwiftData | `swiftdata-pro` |
| iOS norms / structure | `ios-dev-guide` |

### Phase 8 — targeted App Store (one at a time)

Use [process/SKILLS_REGISTRY.md](../../process/SKILLS_REGISTRY.md) § App Store review skills, or `appstore-full-audit.md` in `.cursor/app-store-agents/`, `.claude/agents/`, or `.agents/agents/` for full pass.

## How to delegate (required format)

When spawning a subagent or continuing as another role, your prompt **must** include:

```text
Role: Read roles/<role>.md
Skill: Invoke skill <exact-skill-name>. Follow <skills-dir>/<exact-skill-name>/SKILL.md (.cursor/skills, .claude/skills, or .agents/skills)
Context: docs/KICKOFF.md guardrails, docs/BACKLOG.md ticket P0-X
Output: <file path>
Do not change scope outside the ticket.
```

Example:

```text
Role: roles/engineer.md
Skill: swiftui-pro
Ticket: P0-2 in docs/BACKLOG.md
Output: implementation + note build in STATUS.md
```

## Subagent types (Cursor Task tool)

| Type | Use for |
|------|---------|
| `explore` | Readonly codebase discovery |
| `generalPurpose` | Spec, UX, architect, engineer with role+skill prompt |
| `shell` | `swift build`, `xcodebuild`, git |

You merge results and **only you** update `docs/STATUS.md` and backlog priority.

## Record in STATUS.md

Always set:

- **Phase**
- **Active role**
- **Active skill:** `skill-name`
- **Next action** (one imperative)
- **Handoff queue** table

## Install / refresh skills in this repo

```bash
# From Lab App meta-repo:
./scripts/sync-project-skills.sh /path/to/this-app

# Or full install:
./scripts/install-agents.sh /path/to/this-app
```

## Stop and escalate

- Skill missing from the active skills folder → run `sync-project-skills.sh`; do not guess.
- P0 audit item open → no App Store submit.
- No `credentials.local.md` → skip `app-store-connect`; human uses ASC web.
