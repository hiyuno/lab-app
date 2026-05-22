# __APP_NAME__ — Skills (Orchestrator)

**Director:** read this file when assigning agents. Full registry: [process/SKILLS_REGISTRY.md](../process/SKILLS_REGISTRY.md).

## Quick phase → skill map

| Phase | Invoke |
|-------|--------|
| Orchestration | `director-orchestrate` |
| 2 Spec | role `product-spec` (no skill) |
| 3 Design | `ui-ux-pro-max`, `design-with-claude`, `libre-uiux` + `ux-ios` / `ux-macos` |
| 4 Arch (iOS) | `ios-dev-guide`, `swiftdata-pro` if needed |
| 6 Build UI | `swiftui-pro` + `execute-backlog-ticket` |
| 6 Build async | `swift-concurrency-pro` |
| 6 Build data | `swiftdata-pro` |
| 8 App Store | `app-store-release` → `apple-app-review` / `app-store-connect` |

All skills are under `.cursor/skills/`. List installed:

```bash
ls .cursor/skills
```

Refresh from Lab App:

```bash
/path/to/lab-app/scripts/sync-project-skills.sh .
```

## Active assignment (Director updates each session)

**Active skill:** `director-orchestrate`  
**Next delegation:** _fill when assigning subagent_
