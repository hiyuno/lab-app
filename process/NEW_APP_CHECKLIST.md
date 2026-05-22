# New app checklist

## Human steps

1. Choose app name (PascalCase, no spaces) and stack: `ios` or `macos`.
2. Write a one-paragraph intake: problem, user, non-goals.
3. Run from Lab App root:

   ```bash
   ./scripts/new-app.sh MyApp ios
   ```

4. Open the new folder `../MyApp/` in Cursor (separate workspace).
5. Edit `docs/KICKOFF.md` — objective, guardrails, definition of done.
6. Approve phase progression in `docs/STATUS.md` (Director or you).

## Agent steps (Director)

1. Confirm `docs/STATUS.md` phase is `1-kickoff` or `2-spec`.
2. Load `roles/director.md` and skill `director-orchestrate`.
3. Delegate Product Spec to fill `PRD.md` and P0 section of `BACKLOG.md`.
4. After human approval, advance phase in `STATUS.md`.

## After scaffold (phase 5+)

- iOS: Open `MyApp.xcodeproj`, set Development Team in Signing if needed, build for simulator.
- macOS: `cd ../MyApp && swift build` then run the executable target.

## Validate docs

```bash
./scripts/sync-status.sh ../MyApp
```

## Do not

- Store app source inside Lab App
- Create duplicate version folders; use git branches
- Implement features without a backlog ticket
