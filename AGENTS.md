# Lab App — Agent Operating Guide

Process hub for iOS and macOS apps. When working **inside a spawned app**, always read that app's `docs/STATUS.md` and `docs/KICKOFF.md` first.

## Roles

### 1) Director (PM + Tech Lead)
**Owner:** coordination, priority, final scope decisions.  
**Inputs:** PRD, backlog, design, architecture, implementation status.  
**Outputs:** `docs/STATUS.md`, sequencing, one clear next action.  
**Skill:** `director-orchestrate`

### 2) Product Spec
**Owner:** executable product specs.  
**Inputs:** PRD + guardrails from `docs/KICKOFF.md`.  
**Outputs:** epics, stories, `docs/BACKLOG.md` with acceptance criteria.  
**Success:** engineers never guess expected behavior.

### 3) UX / UI (iOS or macOS)
**Owner:** interaction quality and flow clarity.  
**Inputs:** prioritized tickets.  
**Outputs:** `docs/SCREENS.md`, wireflows, states, interactions.  
**Role files:** `roles/ux-ios.md`, `roles/ux-macos.md`  
**Design libraries (phase 3):** skills `ui-ux-pro-max`, `design-with-claude`, `libre-uiux` — see [process/DESIGN_AGENTS.md](process/DESIGN_AGENTS.md)

### 4) Brand + Content
**Owner:** tone and copy.  
**Inputs:** UX flows and product intent.  
**Outputs:** `docs/COPY.md`, notification strings, empty states.

### 5) Architect (iOS or macOS)
**Owner:** technical shape and reliability.  
**Inputs:** product + UX requirements.  
**Outputs:** `docs/ARCHITECTURE.md`, optional `docs/decisions/ADR-*.md`.  
**Role files:** `roles/architect-ios.md`, `roles/architect-macos.md`  
**Swift libraries (iOS, phases 4–6):** `ios-dev-guide`, `swift-agent-skills`, `swiftdata-pro` — see [process/SWIFT_AGENTS.md](process/SWIFT_AGENTS.md)

### 6) Feature Engineer
**Owner:** shipping features.  
**Inputs:** approved spec + UX + architecture.  
**Outputs:** working code, build verification, ticket closure notes.  
**Swift libraries (iOS, phase 6):** `swiftui-pro`, `swift-concurrency-pro`, `swiftdata-pro`, `ios-dev-guide`, `execute-backlog-ticket`

### 7) QA / Reviewer
**Owner:** manual validation before alpha.  
**Inputs:** closed P0 tickets, build artifact.  
**Outputs:** `docs/QA.md` checklist results.

## Handoff protocol

1. Spec defines behavior → `docs/BACKLOG.md`
2. UX defines interaction → `docs/SCREENS.md` or ticket updates
3. Content defines language → `docs/COPY.md`
4. Architecture validates feasibility → `docs/ARCHITECTURE.md`
5. Engineering ships → code + backlog checkboxes
6. Director approves and reprioritizes → `docs/STATUS.md`

Do not skip steps. Do not implement without an open backlog ticket.

## Session rules

1. Read `docs/STATUS.md`, then `docs/KICKOFF.md`.
2. Only work tickets listed in `docs/BACKLOG.md`.
3. Do not change product guardrails without Director approval (note in `STATUS.md`).
4. End every session by updating `docs/STATUS.md`.
