# External design agent libraries

Git submodules — update with `git submodule update --init --recursive`.

| Submodule | Source | Use in Lab App |
|-----------|--------|----------------|
| [design-with-claude](design-with-claude/) | [imsaif/design-with-claude](https://github.com/imsaif/design-with-claude) | 41 design specialist commands (Claude Code style); Cursor via skill `design-with-claude` |
| [ui-ux-pro-max-skill](ui-ux-pro-max-skill/) | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Upstream source; Cursor install is `.cursor/skills/ui-ux-pro-max/` (run `scripts/install-design-agents.sh`) |
| [LibreUIUX-Claude-Code](LibreUIUX-Claude-Code/) | [HermeticOrmus/LibreUIUX-Claude-Code](https://github.com/HermeticOrmus/LibreUIUX-Claude-Code) | Plugins, agents, skills; Cursor via skill `libre-uiux` |

## Install / refresh Cursor skills

From Lab App root:

```bash
./scripts/install-design-agents.sh
```

## Licenses

Each submodule has its own LICENSE. Do not remove attribution when copying or referencing files.
