---
name: new-app
description: >-
  Scaffolds a new iOS or macOS app as a sibling folder under Github using Lab App
  templates and scripts. Use when the user wants to create a new app, spawn a project
  from Lab App, or run the new-app checklist.
---

# New app (Lab App)

## Prerequisites

- Working directory: Lab App repo root (`scripts/new-app.sh` lives here).
- App name: PascalCase, no spaces (e.g. `LabAppDemo`).
- Stack: `ios` or `macos`.

## Steps

1. Read [process/NEW_APP_CHECKLIST.md](../../process/NEW_APP_CHECKLIST.md).
2. Confirm name and stack with the user if unclear.
3. Run:

   ```bash
   ./scripts/new-app.sh <AppName> <ios|macos>
   ```

4. Validate:

   ```bash
   ./scripts/sync-status.sh ../<AppName>
   ```

5. Tell the user to open `../<AppName>` in Cursor and edit `docs/KICKOFF.md` and `docs/STATUS.md`.

## After scaffold

| Stack | Build check |
|-------|-------------|
| ios | Open `<AppName>.xcodeproj`, set Signing team if needed, build simulator |
| macos | `cd ../<AppName> && swift build` |

## Do not

- Create app source inside Lab App (meta-repo only).
- Skip copying `docs/`, `roles/`, `.cursor/rules/`, and root `AGENTS.md`.
