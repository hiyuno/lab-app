# Lab App

https://github.com/hiyuno/lab-app

Meta-repository for creating **iOS** and **macOS** apps with a repeatable, agent-friendly process. App source code lives in **sibling folders** under `Github/` (for example `Goals/`, `MyApp/`), not inside Lab App.

## Start here

| Audience | First read |
|----------|------------|
| Human | [process/NEW_APP_CHECKLIST.md](process/NEW_APP_CHECKLIST.md) |
| **Director / Orchestrator** | [process/SKILLS_REGISTRY.md](process/SKILLS_REGISTRY.md) + skill `director-orchestrate` |
| Any agent in Lab App | [AGENTS.md](AGENTS.md) |
| Any agent in an app repo | `docs/STATUS.md` → `docs/KICKOFF.md` → `docs/SKILLS.md` |

Sync all skills into an app repo:

```bash
./scripts/sync-project-skills.sh ../MyApp
```

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

## Swift / iOS programming agents

| Skill | Source |
|-------|--------|
| `swift-agent-skills` | [twostraws/swift-agent-skills](https://github.com/twostraws/swift-agent-skills) (catalog) |
| `swiftui-pro` / `swift-concurrency-pro` / `swiftdata-pro` | [twostraws](https://github.com/twostraws) Agent Skills |
| `ios-dev-guide` | [claude-code-ios-dev-guide](https://github.com/keskinonur/claude-code-ios-dev-guide) |

```bash
./scripts/install-swift-agents.sh
# or: ./scripts/install-agents.sh
```

Details: [process/SWIFT_AGENTS.md](process/SWIFT_AGENTS.md).

## App Store (iOS submit readiness)

| Skill | Source |
|-------|--------|
| `apple-app-review` | [apple-app-review-skills](https://github.com/cruisediary/apple-app-review-skills) — 31 rejection checks |
| `app-store-connect` | [app-store-connect-skill](https://github.com/sosteam65/app-store-connect-skill) — ASC API |
| `app-store-release` | Lab App orchestrator |

```bash
./scripts/install-appstore-agents.sh   # included in install-agents.sh
```

Details: [process/APPSTORE_AGENTS.md](process/APPSTORE_AGENTS.md). Auto-installed for `new-app.sh MyApp ios`.

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
