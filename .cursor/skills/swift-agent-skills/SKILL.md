---
name: swift-agent-skills
description: >-
  Curated index of community Swift and Apple platform agent skills from
  twostraws/swift-agent-skills. Use when choosing which Swift skill to load for
  SwiftUI, SwiftData, concurrency, testing, or architecture during iOS/macOS build phases.
---

# Swift Agent Skills (catalog)

Upstream index: `external/swift-agent-skills/README.md`  
Maintainer: [twostraws/swift-agent-skills](https://github.com/twostraws/swift-agent-skills)

**Safety:** Read any third-party skill before use. Listing here is not an endorsement.

## Pre-installed in Lab App (twostraws “Pro” skills)

| Skill | Invoke | Topic |
|-------|--------|-------|
| SwiftUI Pro | `swiftui-pro` | Views, navigation, performance, HIG |
| Swift Concurrency Pro | `swift-concurrency-pro` | async/await, actors, Swift 6 |
| SwiftData Pro | `swiftdata-pro` | Persistence, models, queries |

Install or refresh:

```bash
./scripts/install-swift-agents.sh
```

## Pick by backlog topic

| Ticket needs | Catalog section (read README) | Prefer skill |
|--------------|-------------------------------|--------------|
| UI / screens | SwiftUI Skills | `swiftui-pro` |
| Persistence | SwiftData / Core Data | `swiftdata-pro` or catalog link |
| Background / async | Swift Concurrency | `swift-concurrency-pro` |
| Unit tests | Swift Testing Skills | catalog link |
| App Store / ASC | App Store Skills | catalog link |
| Accessibility | Accessibility Skills | catalog + `design-with-claude` accessibility |
| Architecture | Architecture Skills | `roles/architect-ios.md` + catalog |

## Workflow (Engineer / Architect)

1. Read active P0 and `docs/ARCHITECTURE.md`.
2. Open `external/swift-agent-skills/README.md` for extra skills not vendored locally.
3. Invoke the matching **Pro** skill for implementation or review.
4. Record notable conventions in `docs/ARCHITECTURE.md` if new patterns are adopted.

## Submodule missing?

```bash
git submodule update --init external/swift-agent-skills
```
