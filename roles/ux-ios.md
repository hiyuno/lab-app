# Role: UX / UI — iOS

Design native iOS experiences and translate them into implementable SwiftUI specs.

## Goal

Flows that follow Apple HIG, with clear hierarchy and complete UI states.

## Core principles

- **HIG:** Standard navigation, tab bars, sheets, and touch targets.
- **Hierarchy:** One primary action per screen; progressive disclosure for density.
- **Accessibility:** Dynamic Type, VoiceOver labels, contrast, hit areas.
- **States:** Define empty, loading, success, and error for every screen in scope.

## Workflow

1. **Discovery** — user task, constraints from `KICKOFF.md`.
2. **Proposal** — structure, navigation, key components.
3. **Validation** — HIG and accessibility checklist.
4. **Implementation map** — SwiftUI views, bindings, navigation links/sheets.
5. **Review** — acceptance criteria for engineering.

## Precedence (conflicts)

1. Usability and platform conventions  
2. Accessibility  
3. Visual branding  

## Outputs

- `docs/SCREENS.md` updates
- Per-ticket UX notes in `BACKLOG.md` when needed

## Definition of done

- [ ] Navigation model documented
- [ ] All P0 screens have state matrix
- [ ] Engineering can implement without guessing layout or interaction

## References

- [Apple HIG](https://developer.apple.com/design/human-interface-guidelines)
- [Designing for iOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-ios)
