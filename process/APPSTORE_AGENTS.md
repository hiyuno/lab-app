# App Store agents (review + Connect)

Used in **phase 7–8** for **iOS** apps targeting the App Store. Answers: *what must we have, what must we avoid, and what can we automate before upload?*

## Cursor skills

| Skill | Source | Purpose |
|-------|--------|---------|
| `apple-app-review` | [apple-app-review-skills](https://github.com/cruisediary/apple-app-review-skills) | Router — 31 guideline checks (privacy, IAP, layout, metadata, UGC) |
| `app-store-connect` | [app-store-connect-skill](https://github.com/sosteam65/app-store-connect-skill) | ASC API: metadata, screenshots, TestFlight, submit (needs API key) |
| `app-store-release` | Lab App | Orchestrates audit → checklist → Connect |

After install, individual checks appear as skills (e.g. `privacy-manifest-check`, `subscription-disclosure`, `review-readiness-check`).

## Agents (full audits)

| Agent file | Use |
|------------|-----|
| `.cursor/app-store-agents/appstore-full-audit.md` | Full pre-submission audit → `docs/APPSTORE_AUDIT.md` |
| `ipad-layout-agent.md` | iPad / Dynamic Type / safe area |
| `privacy-audit-agent.md` | Privacy manifest, ATT, account deletion |
| `permission-audit-agent.md` | Permission strings and timing |
| `ugc-safety-agent.md` | Report/block for user content |

Upstream copies live in `external/apple-app-review-skills/agents/` if agents were not installed.

## Common rejection themes (must fix before submit)

| Area | Examples | Skill |
|------|----------|-------|
| Privacy | `PrivacyInfo.xcprivacy`, account deletion, policy URL | `privacy-manifest-check`, `account-deletion-check` |
| Permissions | Prompt at launch without context | `request-timing-audit` |
| Business | IAP bypass, subscription price disclosure, Sign in with Apple | `iap-compliance`, `subscription-disclosure` |
| Quality | Crashes, lorem ipsum, broken support URL | `crash-risk-audit`, `app-completeness-check` |
| Metadata | Screenshots not real UI, “beta” in name | `screenshot-guidelines`, `app-name-compliance` |
| Layout | iPad broken layout, Dynamic Type clipped | `ipad-layout-audit`, `dynamic-type-support` |

Full table: `external/apple-app-review-skills/README.md` (real rejection cases).

## App Store Connect — manual vs API

| Task | API (`app-store-connect`) | Manual (ASC website) |
|------|---------------------------|----------------------|
| Update description, keywords | Yes | Yes |
| Upload screenshots / previews | Yes | Yes |
| TestFlight groups | Yes | Yes |
| Submit for review | Yes | Yes |
| **Create new app** | No | Yes |
| **App Privacy questionnaire** | No | Yes |
| **App icon** | No (in Xcode build) | Via new build |
| Delete / transfer app | No | Yes |

Credentials: copy `config/credentials.local.md.example` → `credentials.local.md` (gitignored).

## Lab App artifacts

| File | When |
|------|------|
| `docs/APPSTORE_AUDIT.md` | After full or targeted audit |
| `docs/APPSTORE_CHECKLIST.md` | Human + agent sign-off before submit |

## Director — phase 8

1. Confirm P0 QA done (`docs/QA.md`).
2. Run `app-store-release` or `apple-app-review` → `appstore-full-audit`.
3. File P0/P1 fixes as backlog tickets; do not submit with open P0 audit items.
4. Optional: `app-store-connect` for metadata/upload if credentials configured.
5. Update `docs/STATUS.md` → submitted / waiting for review.

## Install

```bash
./scripts/install-appstore-agents.sh
# or all agents:
./scripts/install-agents.sh
```

iOS apps from `new-app.sh` run this automatically for `ios` stack.
