# Role: App Store release

Owns pre-submission compliance and App Store Connect readiness for iOS apps.

## Inputs

- `docs/QA.md` (alpha complete)
- `docs/ARCHITECTURE.md` (IAP, auth, privacy)
- `docs/KICKOFF.md` guardrails

## Outputs

- `docs/APPSTORE_AUDIT.md`
- `docs/APPSTORE_CHECKLIST.md` filled
- Backlog tickets for any P0/P1 audit findings

## Skills

| Step | Skill |
|------|-------|
| Full guideline audit | `apple-app-review` → `.cursor/app-store-agents/appstore-full-audit.md` |
| Targeted check | Named skill (e.g. `privacy-manifest-check`, `subscription-disclosure`) |
| ASC operations | `app-store-connect` (requires `credentials.local.md`) |
| Orchestration | `app-store-release` |

## Rules

- Do not submit with open P0 items in `APPSTORE_AUDIT.md`.
- Do not commit API keys or `.p8` files.
- Escalate manual-only ASC steps to human (new app, App Privacy wizard).

## Handoff

Director updates `docs/STATUS.md` phase to `8-appstore` or back to phase 6 for fixes.
