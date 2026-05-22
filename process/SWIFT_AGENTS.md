# Swift / iOS programming agents

Used in **phases 4–6** (Architecture and Build) for **iOS** apps. macOS SwiftPM apps use the same Swift skills where applicable.

## Cursor skills

| Skill | Source | When |
|-------|--------|------|
| `swift-agent-skills` | [swift-agent-skills](https://github.com/twostraws/swift-agent-skills) | Pick catalog skill for ticket type |
| `swiftui-pro` | [SwiftUI-Agent-Skill](https://github.com/twostraws/SwiftUI-Agent-Skill) | UI implementation and review |
| `swift-concurrency-pro` | [Swift-Concurrency-Agent-Skill](https://github.com/twostraws/Swift-Concurrency-Agent-Skill) | async/await, actors |
| `swiftdata-pro` | [SwiftData-Agent-Skill](https://github.com/twostraws/SwiftData-Agent-Skill) | SwiftData persistence |
| `ios-dev-guide` | [claude-code-ios-dev-guide](https://github.com/keskinonur/claude-code-ios-dev-guide) | PRD workflow, structure, testing norms |

## Lab App roles

| Role | File | Swift skills |
|------|------|--------------|
| iOS Architect | `roles/architect-ios.md` | `ios-dev-guide`, `swift-agent-skills` |
| Engineer | `roles/engineer.md` | `swiftui-pro`, `swift-concurrency-pro`, `swiftdata-pro`, `ios-dev-guide` |
| Director | `roles/director.md` | Assigns skills per ticket |

## Director — phase 4 (Architecture)

1. Engineer/architect reads `ios-dev-guide` § structure + MVVM.
2. Document decisions in `docs/ARCHITECTURE.md`.
3. If persistence → note SwiftData vs alternatives; invoke `swiftdata-pro` for model design review.

## Director — phase 6 (Build)

Per P0 ticket:

| Ticket type | Skills |
|-------------|--------|
| SwiftUI screen | `swiftui-pro` + `execute-backlog-ticket` |
| Async / networking | `swift-concurrency-pro` |
| SwiftData / storage | `swiftdata-pro` |
| New pattern / library | `swift-agent-skills` → catalog README |

After implementation: run `swiftui-pro` as **review pass** before marking P0 done.

## Catalog (more skills)

`external/swift-agent-skills/README.md` links to community skills (testing, App Store, security, simulator, etc.). Install manually from linked repos when needed; read each skill before use.

## Install

```bash
./scripts/install-swift-agents.sh
# or everything:
./scripts/install-agents.sh
```

Clone with submodules:

```bash
git clone --recurse-submodules https://github.com/hiyuno/lab-app.git
```
