# Lab App

https://github.com/hiyuno/lab-app

Meta-repository for creating **iOS** and **macOS** apps with a repeatable, agent-friendly process. App source code lives in **sibling folders** under `Github/` (for example `Goals/`, `MyApp/`), not inside Lab App.

## Start here

| Audience | First read |
|----------|------------|
| Human | [process/NEW_APP_CHECKLIST.md](process/NEW_APP_CHECKLIST.md) |
| Director agent | [roles/director.md](roles/director.md) + skill `.cursor/skills/director-orchestrate/` |
| Any agent in Lab App | [AGENTS.md](AGENTS.md) |
| Any agent in an app repo | App `docs/STATUS.md` then `docs/KICKOFF.md` |

## Design agent libraries

Integrated via git submodules + Cursor skills:

| Library | Skill name |
|---------|------------|
| [ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | `ui-ux-pro-max` |
| [design-with-claude](https://github.com/imsaif/design-with-claude) | `design-with-claude` |
| [LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code) | `libre-uiux` |

Install or refresh:

```bash
git submodule update --init --recursive
./scripts/install-design-agents.sh
```

Details: [process/DESIGN_AGENTS.md](process/DESIGN_AGENTS.md).

## Create a new app

```bash
./scripts/new-app.sh MyApp ios
# or
./scripts/new-app.sh MyApp macos
```

This scaffolds `../MyApp/` with docs, roles, Cursor rules, and a minimal SwiftUI project.

## Layout

```
Lab App/
├── AGENTS.md           # Roles and handoff protocol
├── process/            # Phases, checklist, handoffs
├── templates/          # app-docs + ios-xcode + macos-swiftpm
├── roles/              # Role prompts (copied into each new app)
├── .cursor/rules/      # Agent guardrails
├── .cursor/skills/     # new-app, director-orchestrate, execute-backlog-ticket
└── scripts/            # new-app.sh, sync-status.sh
```

## Versioning apps

Use **git branches** inside one app folder. Do not duplicate folders like `MyApp v0.2/` unless archiving intentionally.

## Out of scope (v1)

Web stacks (Next.js, static sites), TestFlight, and notarization pipelines are documented as future work in [process/PHASES.md](process/PHASES.md).
