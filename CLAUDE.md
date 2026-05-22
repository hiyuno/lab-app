# . — Claude Code

This project uses the **Lab App** iOS/macOS process. Full protocol: [AGENTS.md](AGENTS.md).

## Session start

1. Read `docs/STATUS.md` → `docs/KICKOFF.md` → `docs/SKILLS.md`
2. Read `process/SKILLS_REGISTRY.md` for skill names
3. As **Director**, invoke skill **`director-orchestrate`** (`.claude/skills/director-orchestrate/SKILL.md`)

Skills live in **`.claude/skills/<name>/SKILL.md`** (same names as Cursor and Antigravity).

## Director / Orchestrator

- Registry: `process/SKILLS_REGISTRY.md`
- Delegate with: `roles/<role>.md` + `Use skill <skill-name>`
- App Store agents: `.claude/agents/` (e.g. `appstore-full-audit.md`)
- Only implement open tickets in `docs/BACKLOG.md`
- End session: update `docs/STATUS.md` (phase, role, active skill, next action)

## Intake (new apps)

If `docs/INTAKE.md` still has empty **Platform** or **App idea**, follow `process/INTAKE.md` and `.agents/workflows/intake-first.md` — ask platform (iOS / macOS / both) and app idea **before** any lab-app or `new-app.sh` discussion.

## Refresh skills from Lab App

```bash
/path/to/lab-app/scripts/sync-project-skills.sh .
```
