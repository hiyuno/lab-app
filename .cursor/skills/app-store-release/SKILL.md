---
name: app-store-release
description: >-
  Coordinates App Store submission readiness for iOS apps: review guidelines audit
  (apple-app-review), metadata and ASC operations (app-store-connect). Use before
  TestFlight external beta or App Store submit, in phase 7–8 or when user asks what
  is required for App Store upload.
---

# App Store release (Lab App)

Use when the app is near alpha complete and targeting the App Store.

## Read first

1. App `docs/STATUS.md` — phase should be `7-alpha` or `8-appstore`
2. App `docs/KICKOFF.md` — scope and monetization
3. App `docs/ARCHITECTURE.md` — IAP, Sign in with Apple, privacy

## Step 1 — Rejection prevention (required)

Invoke **`apple-app-review`** or run full audit:

- Read `.cursor/app-store-agents/appstore-full-audit.md` if installed, else `external/apple-app-review-skills/agents/appstore-full-audit.md`
- Save report to `docs/APPSTORE_AUDIT.md` (use template `templates/app-docs/APPSTORE_AUDIT.md`)

Target **P0 blockers** before any submit.

## Step 2 — Metadata & ASC (when uploading)

Invoke **`app-store-connect`** only if API credentials exist:

- Copy `config/credentials.local.md.example` → `credentials.local.md` (never commit)
- Follow skill references for metadata, screenshots, TestFlight, submit

**Cannot automate via API** (manual in App Store Connect):

- Create new app record
- App Privacy questionnaire
- App icon (comes from Xcode build)
- Delete / transfer app

## Step 3 — Lab App checklist

Fill `docs/APPSTORE_CHECKLIST.md` with pass/fail per section.

## Director handoff

| Result | Next |
|--------|------|
| P0 audit failures | Back to Engineer / UX tickets |
| Audit pass, no credentials | Human completes ASC manually with checklist |
| Audit pass + credentials | `app-store-connect` for upload/submit |

## Pair with

- `swiftui-pro` — UI issues found in layout audit
- `ios-dev-guide` — structure and testing norms
