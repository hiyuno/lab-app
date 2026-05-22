---
name: design-with-claude
description: >-
  Routes design briefs to specialist agents from imsaif/design-with-claude (accessibility,
  mobile, motion, forms, design systems). Use in Lab App phase 3 design or when the user
  wants design-with-claude, DWIC, or specialist design guidance for iOS/macOS UI.
---

# Design with Claude (Lab App integration)

Upstream: [imsaif/design-with-claude](https://github.com/imsaif/design-with-claude)  
Local commands: `external/design-with-claude/commands/` (git submodule)

## When to use

- Phase **3 — Design**, after `docs/KICKOFF.md` guardrails and P0 tickets exist.
- Pair with Lab App roles `roles/ux-ios.md` or `roles/ux-macos.md`.
- Outputs feed `docs/SCREENS.md` and inform `docs/COPY.md`.

## Workflow

1. Read `docs/KICKOFF.md` and active P0 tickets in `docs/BACKLOG.md`.
2. Open **`external/design-with-claude/commands/design-brief.md`** and follow it for the user brief.
3. For iOS/macOS apps, also read as needed:
   - `mobile-specialist.md`
   - `accessibility-specialist.md`
   - `interaction-designer.md`
   - `visual-hierarchy-specialist.md`
   - `motion-designer.md`
   - `error-handling-specialist.md`
4. Translate web-oriented examples to **SwiftUI** and Apple HIG (native patterns over web-first).
5. Write actionable specs into `docs/SCREENS.md` with verifiable acceptance criteria.

## Rules

- Do not override `KICKOFF.md` product guardrails.
- Prefer Apple HIG over generic web patterns for iOS/macOS targets.
- Do not implement code unless Director moved phase to 6 and a backlog ticket is open.

## Submodule missing?

```bash
git submodule update --init external/design-with-claude
```
