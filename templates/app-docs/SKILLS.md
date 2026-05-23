# __APP_NAME__ — Skills (Orchestrator)

**Director:** read this file when assigning agents. Full registry: [process/SKILLS_REGISTRY.md](../process/SKILLS_REGISTRY.md).

## Quick phase → skill map

| Phase | Invoke |
|-------|--------|
| Orchestration | `director-orchestrate` |
| 2 Spec | role `product-spec` (no skill) |
| 3 Design | `ui-ux-pro-max`, `ios-mac-ui-designer`, `design-with-claude`, `libre-uiux` + `ux-ios` / `ux-macos` |
| 4 Arch (iOS) | `ios-dev-guide`, `swiftdata-pro` if needed |
| 6 Build UI | `swiftui-pro` + `execute-backlog-ticket` |
| 6 Build async | `swift-concurrency-pro` |
| 6 Build data | `swiftdata-pro` |
| 8 App Store | `app-store-release` → `apple-app-review` / `app-store-connect` |

Skills are installed for **Cursor**, **Claude Code**, and **Antigravity** (same names):

| IDE | Path |
|-----|------|
| Cursor | `.cursor/skills/<name>/SKILL.md` |
| Claude Code | `.claude/skills/<name>/SKILL.md` |
| Antigravity | `.agents/skills/<name>/SKILL.md` |

See [process/PLATFORMS.md](../process/PLATFORMS.md).

List installed (Cursor):

```bash
ls .cursor/skills
```

Refresh all platforms from Lab App:

```bash
/path/to/lab-app/scripts/sync-project-skills.sh .
```

## Active assignment (Director updates each session)

**Active skill:** `director-orchestrate`  
**Next delegation:** _fill when assigning subagent_
