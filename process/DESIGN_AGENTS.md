# Design agent libraries (external)

Used in **phase 3 — Design** after Product Spec. The Director assigns UX + Content; these libraries deepen UI/UX output for iOS/macOS (and SwiftUI stack in UI UX Pro Max).

## Cursor skills (invoke by name)

| Skill | Source | When to use |
|-------|--------|-------------|
| `steve-ui` | Bundled (`.cursor/skills/steve-ui/`) | Analiza screenshots de referencia → acumula `docs/STYLE_DNA.md`; invocar **primero** en fase 3 si el usuario tiene referencias visuales |
| `ui-ux-pro-max` | [ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Design system generation, palettes, typography, UX rules; run `scripts/search.py` for stack `swiftui` |
| `ios-mac-ui-designer` | Bundled (`.cursor/skills/ios-mac-ui-designer/`) | Apple HIG-native UI for iOS, iPadOS, macOS — screens, flows, navigation patterns, design review |
| `design-with-claude` | [design-with-claude](https://github.com/imsaif/design-with-claude) | Brief routing to specialists (`design-brief`, mobile, accessibility, motion, forms, etc.) |
| `libre-uiux` | [LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code) | Premium SaaS patterns, accessibility compliance, design critique |

## Lab App roles (always)

| Role | File |
|------|------|
| UX iOS | `roles/ux-ios.md` |
| UX macOS | `roles/ux-macos.md` |
| Brand + Content | `roles/brand-content.md` |

**Order:** Lab role defines platform (HIG, SwiftUI) → external skill adds design intelligence → output goes to `docs/SCREENS.md` and `docs/COPY.md`.

## steve-ui — acumulación de estilo personal

`steve-ui` convierte screenshots de referencia en un documento vivo (`docs/STYLE_DNA.md`) que actúa como guía de estilo personal del usuario. Es el punto de partida visual de cualquier app nueva.

**Cuándo invocarlo:**
- Al inicio de fase 3, antes de cualquier trabajo de diseño, si el usuario tiene referencias
- Cada vez que el usuario comparte nuevas referencias durante el proceso
- Cuando el UX designer necesita dirección visual concreta antes de proponer pantallas
- Fuera de cualquier fase específica — el usuario puede ir acumulando su estilo en cualquier momento

**Cómo funciona:**
1. Usuario comparte screenshot(s) de apps que le gustan
2. `steve-ui` extrae: paleta de colores, tipografía, espaciado, forma, profundidad, componentes, iconografía
3. Acumula los hallazgos en `docs/STYLE_DNA.md` (vive junto a `SCREENS.md` y `COPY.md`)
4. Con cada nueva referencia, el documento se vuelve más específico y más fiel al gusto real
5. Cuando hay conflicto entre referencias, pregunta al usuario antes de sobreescribir
6. Antes de diseñar, `ios-mac-ui-designer` y `ui-ux-pro-max` leen `STYLE_DNA.md` para alinear el output visual

**Output:** `docs/STYLE_DNA.md`  
**Plantilla:** `templates/app-docs/STYLE_DNA.md`

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
2. If user has visual references: invoke `steve-ui` → `docs/STYLE_DNA.md`.
3. Invoke `ui-ux-pro-max` for design-system / style direction (product type + `swiftui` stack); pass `STYLE_DNA.md` as context if available.
4. Invoke `ios-mac-ui-designer` for HIG-native screens and navigation (`docs/SCREENS.md`); read `STYLE_DNA.md` for visual constraints.
5. Invoke `design-with-claude` with `design-brief` for specialist routing.
6. Optional: `libre-uiux` for critique before Engineer handoff.
7. Assign `brand-content` for `docs/COPY.md`.
8. Update `docs/STATUS.md` → phase 4 or 6.

## Install

```bash
./scripts/install-design-agents.sh          # Lab App
./scripts/install-design-agents.sh ../MyApp   # Also install into a spawned app
```

Clone with submodules:

```bash
git clone --recurse-submodules https://github.com/hiyuno/lab-app.git
```
