# Multi-platform agents (Cursor, Claude Code, Antigravity)

Lab App installs the **same skill names** into three project layouts so you can open an app repo in any supported IDE.

| IDE / agent | Skills path | Rules / team | App Store agents |
|-------------|-------------|--------------|------------------|
| **Cursor** | `.cursor/skills/<name>/SKILL.md` | `.cursor/rules/*.mdc` | `.cursor/app-store-agents/` |
| **Claude Code** | `.claude/skills/<name>/SKILL.md` | `CLAUDE.md` (project root) | `.claude/agents/` |
| **Antigravity** | `.agents/skills/<name>/SKILL.md` | `.agents/agents.md` + `.agents/workflows/` | `.agents/agents/` |

Skills follow the [agentskills.io](https://agentskills.io) layout (`SKILL.md` + optional `scripts/`, `references/`).

## Sync into an app repo

From Lab App:

```bash
./scripts/sync-project-skills.sh ../MyApp
```

This copies:

- All Lab App skills → `.cursor/`, `.claude/`, `.agents/skills/`
- Process docs → `process/`
- `docs/SKILLS.md`, rules, `CLAUDE.md`, `.agents/agents.md`, intake workflow

Full external libraries (design, Swift, App Store):

```bash
./scripts/install-agents.sh ../MyApp
```

## Intake workspace (platform + idea first)

```bash
./scripts/init-workspace.sh MyApp
```

Creates intake rules for **all three** platforms. Open `../MyApp` in Cursor, Claude Code, or Antigravity — Director asks platform + idea first.

## Which tool to use

| Task | Cursor | Claude Code | Antigravity |
|------|--------|-------------|-------------|
| Subagents / Task tool | Yes | Agent tool | Agent manager |
| Slash commands (App Store) | Via skills | `/appstore-detect`, etc. | Workflows in `.agents/workflows/` |
| Recommended mode | Agent (not Plan) | Default | Agent / autonomous |

## Lab App meta-repo only

When editing **Lab App** itself (not an app sibling), read [AGENTS.md](../AGENTS.md). Skills are authored under `.cursor/skills/` and synced to sibling apps; optional local copies:

```bash
./scripts/sync-project-skills.sh .
```

## Optional: Codex CLI

[ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) also supports `.codex/skills/`. Lab App does not auto-sync Codex today; run `npx uipro init --ai codex` in the app repo if needed.

## References

- [Google Antigravity — Skills](https://antigravity.google/docs/skills)
- [Claude Code — Skills](https://docs.anthropic.com/claude-code)
- [Cursor — Skills](https://cursor.com/docs/context/skills)
