# Design agent libraries (external)

Used in **phase 3 — Design** after Product Spec. The Director assigns UX + Content; these libraries deepen UI/UX output for iOS/macOS (and SwiftUI stack in UI UX Pro Max).

## Cursor skills (invoke by name)

| Skill | Source | When to use |
|-------|--------|-------------|
| `ui-ux-pro-max` | [ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Design system generation, palettes, typography, UX rules; run `scripts/search.py` for stack `swiftui` |
| `design-with-claude` | [design-with-claude](https://github.com/imsaif/design-with-claude) | Brief routing to specialists (`design-brief`, mobile, accessibility, motion, forms, etc.) |
| `libre-uiux` | [LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code) | Premium SaaS patterns, accessibility compliance, design critique |

## Lab App roles (always)

| Role | File |
|------|------|
| UX iOS | `roles/ux-ios.md` |
| UX macOS | `roles/ux-macos.md` |
| Brand + Content | `roles/brand-content.md` |

**Order:** Lab role defines platform (HIG, SwiftUI) → external skill adds design intelligence → output goes to `docs/SCREENS.md` and `docs/COPY.md`.

## design-with-claude — recommended specialists (iOS/macOS)

Read command files under `external/design-with-claude/commands/`:

| Command file | Use for |
|--------------|---------|
| `design-brief.md` | Master router from product brief |
| `mobile-specialist.md` | Touch, thumb zones, iOS/Android patterns |
| `accessibility-specialist.md` | WCAG, VoiceOver, contrast |
| `interaction-designer.md` | Flows, states, feedback |
| `visual-hierarchy-specialist.md` | Layout, spacing, hierarchy |
| `motion-designer.md` | Transitions, reduced motion |
| `dark-mode-specialist.md` | Surfaces, elevation (if dark mode in scope) |
| `onboarding-specialist.md` | First-run flows |
| `error-handling-specialist.md` | Error and empty states |

## LibreUIUX — recommended paths (iOS/macOS)

Under `external/LibreUIUX-Claude-Code/`:

| Path | Use for |
|------|---------|
| `plugins/design-mastery/skills/` | Visual polish, SaaS layout patterns |
| `plugins/accessibility-compliance/skills/` | WCAG-oriented checks |
| `plugins/frontend-mobile-development/` | Mobile layout patterns (adapt to SwiftUI) |

## Director orchestration (phase 3)

1. Confirm P0 tickets and `docs/PRD.md` exist.
2. Assign UX role (`ux-ios` or `ux-macos`).
3. Invoke `ui-ux-pro-max` for design-system / style direction (product type + `swiftui` stack).
4. Invoke `design-with-claude` with `design-brief` for specialist routing.
5. Optional: `libre-uiux` for critique before Engineer handoff.
6. Assign `brand-content` for `docs/COPY.md`.
7. Update `docs/STATUS.md` → phase 4 or 6.

## Install

```bash
./scripts/install-design-agents.sh          # Lab App
./scripts/install-design-agents.sh ../MyApp   # Also install into a spawned app
```

Clone with submodules:

```bash
git clone --recurse-submodules https://github.com/hiyuno/lab-app.git
```
