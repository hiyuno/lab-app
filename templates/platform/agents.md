# __APP_NAME__ — AI team (Antigravity)

Lab App process hub. Human-readable protocol: [AGENTS.md](../AGENTS.md).

## Roles

| Role | File | When |
|------|------|------|
| Director | `roles/director.md` | Orchestration, STATUS, priorities |
| Product Spec | `roles/product-spec.md` | PRD, backlog |
| UX | `roles/ux-ios.md` or `roles/ux-macos.md` | Screens, flows |
| Content | `roles/brand-content.md` | Copy |
| Architect | `roles/architect-ios.md` or `roles/architect-macos.md` | Architecture |
| Engineer | `roles/engineer.md` | Implementation |
| App Store | `roles/appstore-release.md` | Submit readiness |

## Skills

Invoke skills from **`.agents/skills/<name>/SKILL.md`**. Catalog: `process/SKILLS_REGISTRY.md` and `docs/SKILLS.md`.

**Director skill:** `director-orchestrate`

**Workflow (intake):** `.agents/workflows/intake-first.md` — run before bootstrap on new apps.

## Session rules

1. Read `docs/STATUS.md`, then `docs/KICKOFF.md`
2. Backlog-only implementation
3. Handoff order: Spec → UX → Content → Architecture → Engineering → Director → QA → App Store
4. Update `docs/STATUS.md` at end of each session

## App Store

Pre-submission agents are in `.agents/agents/`. Router skill: `apple-app-review`.
