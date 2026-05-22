---
name: ios-dev-guide
description: >-
  Applies keskinonur/claude-code-ios-dev-guide patterns for PRD-driven iOS/SwiftUI
  work in Cursor: project structure, MVVM, Swift Testing, planning, and Xcode MCP.
  Use for iOS Engineer or Architect roles in phases 4–6.
---

# iOS Dev Guide (Lab App + Cursor)

Upstream: `external/claude-code-ios-dev-guide/README.md`  
Source: [keskinonur/claude-code-ios-dev-guide](https://github.com/keskinonur/claude-code-ios-dev-guide)

Written for Claude Code; map concepts to **Lab App** docs and Cursor workflows.

## Lab App doc mapping

| Guide concept | Lab App file |
|---------------|--------------|
| PRD | `docs/PRD.md` |
| Architecture | `docs/ARCHITECTURE.md` |
| Feature specs | `docs/SCREENS.md` + ticket notes |
| Tasks / backlog | `docs/BACKLOG.md` |
| Status / orchestration | `docs/STATUS.md` |
| Guardrails | `docs/KICKOFF.md` |

## When to use

- **Phase 4 — Architecture:** MVVM, `@Observable`, feature folders, Swift 6 concurrency defaults.
- **Phase 6 — Build:** implementation checklist, testing expectations, avoid anti-patterns in guide §3.
- **Review:** before closing P0, skim guide testing and “DO NOT” sections.

## Read these guide sections (open README)

Search the upstream README for:

1. **§3 CLAUDE.md Setup** — adapt rules into project; Lab App uses `AGENTS.md` + `.cursor/rules/`.
2. **§4 PRD-Driven Development** — aligns with our handoffs (Spec → UX → Arch → Eng).
3. **§16 Complete Project Structure** — feature-based folders for new iOS scaffolds.
4. **§17 Best Practices** — SwiftUI hygiene, testing, planning.

## iOS implementation defaults (from guide, Cursor-safe)

- SwiftUI first; UIKit only when required.
- `@Observable` view models; avoid massive views; feature-based folders.
- Swift Testing (`@Test`) for business logic when tests are in scope.
- No force unwrap without justification; fix Swift 6 concurrency warnings.
- Align with `docs/KICKOFF.md` — do not expand scope beyond open P0.

## Xcode / build (optional)

Guide documents **XcodeBuildMCP** for Claude Code. In Cursor, prefer:

- `xcodebuild` via shell subagent, or
- Xcode GUI build, noted in `docs/STATUS.md`.

## Pair with

- `swiftui-pro` — code review while implementing UI tickets.
- `swift-concurrency-pro` — async flows.
- `swiftdata-pro` — persistence tickets.
- `execute-backlog-ticket` — single P0 discipline.

## Submodule missing?

```bash
git submodule update --init external/claude-code-ios-dev-guide
```
