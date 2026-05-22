# Phase 0 — Intake (Director script)

**This is always the first interaction** in a new app workspace. Do not discuss `lab-app`, cloning, or `new-app.sh` errors until intake is done.

## When intake applies

- `docs/INTAKE.md` exists and **Platform** / **App idea** are still empty, OR
- No `docs/STATUS.md` and workspace was started with `init-workspace.sh`

## Step 1 — Ask platform (required)

Use **AskQuestion** (or ask plainly in chat) with exactly:

**Title:** New app — platform  
**Question:** Which platform should the first version target?

| Option | Meaning |
|--------|---------|
| **ios** | iPhone / iPad — Xcode, SwiftUI, App Store process |
| **macos** | Mac — SwiftPM (or Xcode), Mac App Store later |
| **both** | Both platforms — **default plan:** scaffold **iOS first**, macOS as follow-up milestone in `KICKOFF.md` |

Record the answer in `docs/INTAKE.md` under **Platform**.

## Step 2 — Ask the idea (required)

**Question:** Describe your app idea in a few sentences.

- What is it?
- Who is it for?
- What problem does it solve?
- Anything it must **not** become? (optional)

Record in `docs/INTAKE.md` under **App idea**.

## Step 3 — Bootstrap (after both answers)

From Lab App repo (sibling `Lab App/`):

```bash
cd "../Lab App"   # adjust path if needed
./scripts/new-app.sh <AppName> <ios|macos>
```

Use `ios` or `macos` from intake. If user chose **both**, run `ios` first unless they specify macOS first.

If the app folder already has intake files only (from `init-workspace.sh`), `new-app.sh` will scaffold **into** that folder.

## Step 4 — Kickoff

Copy intake into `docs/KICKOFF.md` (Objective, guardrails). Set `docs/STATUS.md`:

- **Phase:** `1-kickoff`
- **Active skill:** `director-orchestrate`
- **Next action:** Refine guardrails and P0 scope with human

## What NOT to do at intake

- Do not list lab-app clone steps unless user asked for hub setup only
- Do not run full skill install lecture
- Do not start Plan mode technical analysis of empty folders
