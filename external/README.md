# External design agent libraries

Git submodules — update with `git submodule update --init --recursive`.

| Submodule | Source | Use in Lab App |
|-----------|--------|----------------|
| [design-with-claude](design-with-claude/) | [imsaif/design-with-claude](https://github.com/imsaif/design-with-claude) | 41 design specialist commands (Claude Code style); Cursor via skill `design-with-claude` |
| [ui-ux-pro-max-skill](ui-ux-pro-max-skill/) | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Upstream source; Cursor install is `.cursor/skills/ui-ux-pro-max/` (run `scripts/install-design-agents.sh`) |
| [LibreUIUX-Claude-Code](LibreUIUX-Claude-Code/) | [HermeticOrmus/LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code) | Plugins, agents, skills; Cursor via skill `libre-uiux` |
| [swift-agent-skills](swift-agent-skills/) | [twostraws/swift-agent-skills](https://github.com/twostraws/swift-agent-skills) | Curated Swift skill index; Cursor via `swift-agent-skills` |
| [claude-code-ios-dev-guide](claude-code-ios-dev-guide/) | [keskinonur/claude-code-ios-dev-guide](https://github.com/keskinonur/claude-code-ios-dev-guide) | iOS PRD/MVVM guide; Cursor via `ios-dev-guide` |
| [SwiftUI-Agent-Skill](SwiftUI-Agent-Skill/) | [twostraws/SwiftUI-Agent-Skill](https://github.com/twostraws/SwiftUI-Agent-Skill) | Installed as Cursor skill `swiftui-pro` |
| [Swift-Concurrency-Agent-Skill](Swift-Concurrency-Agent-Skill/) | [twostraws/Swift-Concurrency-Agent-Skill](https://github.com/twostraws/Swift-Concurrency-Agent-Skill) | Cursor skill `swift-concurrency-pro` |
| [SwiftData-Agent-Skill](SwiftData-Agent-Skill/) | [twostraws/SwiftData-Agent-Skill](https://github.com/twostraws/SwiftData-Agent-Skill) | Cursor skill `swiftdata-pro` |

## Install / refresh Cursor skills

From Lab App root:

```bash
./scripts/install-agents.sh
```

Or separately:

```bash
./scripts/install-design-agents.sh
./scripts/install-swift-agents.sh
```

## Licenses

Each submodule has its own LICENSE. Do not remove attribution when copying or referencing files.
