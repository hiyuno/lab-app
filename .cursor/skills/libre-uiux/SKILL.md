---
name: libre-uiux
description: >-
  Applies LibreUIUX design and accessibility plugins for UI critique, premium SaaS patterns,
  and compliance checks. Use in Lab App phase 3 design or when the user mentions LibreUIUX
  or HermeticOrmus design agents.
---

# LibreUIUX (Lab App integration)

Upstream: [HermeticOrmus/LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code)  
Local copy: `external/LibreUIUX-Claude-Code/` (git submodule)

## When to use

- After initial `docs/SCREENS.md` draft (critique pass).
- Accessibility review before Engineer implements P0 UI.
- Optional polish pass for consumer/SaaS-style apps.

## Priority paths for iOS/macOS

Read and apply relevant SKILL files under:

| Path | Purpose |
|------|---------|
| `external/LibreUIUX-Claude-Code/plugins/design-mastery/skills/` | Layout, visual hierarchy, premium UI |
| `external/LibreUIUX-Claude-Code/plugins/accessibility-compliance/skills/` | WCAG-oriented review |
| `external/LibreUIUX-Claude-Code/plugins/frontend-mobile-development/` | Mobile patterns (map to SwiftUI) |

Use `external/LibreUIUX-Claude-Code/VOICE_GUIDE.md` for tone consistency with `docs/COPY.md`.

## Workflow

1. Read `docs/SCREENS.md` and `docs/KICKOFF.md`.
2. Pick 1–2 plugin skills matching the screen (do not load the entire repo).
3. Produce a short **critique + fixes** section appended to `docs/SCREENS.md` or as bullet list for Director.
4. Flag blockers for Architect if feasibility is unclear.

## Rules

- Map recommendations to SwiftUI / HIG, not React-only snippets.
- Do not expand scope beyond open P0 tickets without Director approval.

## Submodule missing?

```bash
git submodule update --init external/LibreUIUX-Claude-Code
```
