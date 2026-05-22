# Skills registry (Director / Orchestrator)

**Director: read this file every session** when assigning work. Invoke skills **by exact name** in the subagent prompt or parent chat.

Skills live in `.cursor/skills/<name>/`. After `install-agents.sh` or `new-app.sh`, the app repo has the same tree.

## How the Director uses skills

1. Read `docs/STATUS.md` → note **phase** and **stack** (`ios` / `macos`).
2. Pick **one** role + **one primary skill** (optional secondary) from tables below.
3. In the delegation message, include:
   - Role file: `roles/<role>.md`
   - Skill: `Use skill <skill-name>. Follow its SKILL.md.`
   - Output path: e.g. `docs/SCREENS.md`
4. Subagent or same chat executes; Director updates `STATUS.md` only.

**Do not** load unrelated skills in one turn. **Do not** skip handoff order in `AGENTS.md`.

## Lab App core (always)

| Skill | Phase | Role | Output |
|-------|-------|------|--------|
| `director-orchestrate` | all | Director | `docs/STATUS.md` |
| `new-app` | 5 | Director / human | sibling app repo |
| `execute-backlog-ticket` | 6 | Engineer | one P0 closed |

## Phase 2 — Spec

| Skill | When | Output |
|-------|------|--------|
| — | Use `roles/product-spec.md` only | `docs/PRD.md`, `docs/BACKLOG.md` |

## Phase 3 — Design

| Skill | When | Output |
|-------|------|--------|
| `ui-ux-pro-max` | Design system, colors, typography; stack `swiftui` in scripts | direction for `SCREENS.md` |
| `design-with-claude` | Brief routing, mobile/accessibility specialists | `docs/SCREENS.md` |
| `libre-uiux` | Critique pass after screens draft | notes in `SCREENS.md` |
| `roles/ux-ios.md` or `roles/ux-macos.md` | Always (platform) | `docs/SCREENS.md` |
| `roles/brand-content.md` | After UX draft | `docs/COPY.md` |

## Phase 4 — Architecture

| Skill | When | Stack | Output |
|-------|------|-------|--------|
| `ios-dev-guide` | iOS structure, MVVM, PRD alignment | ios | `docs/ARCHITECTURE.md` |
| `swift-agent-skills` | Pick extra catalog skills | ios | ADR / architecture |
| `swiftdata-pro` | SwiftData in scope | ios | persistence section |
| `roles/architect-ios.md` / `architect-macos.md` | Always | both | `docs/ARCHITECTURE.md` |

## Phase 5 — Scaffold

| Skill | When | Output |
|-------|------|--------|
| `new-app` | New repo from Lab App only | green scaffold |
| — | Engineer verifies build | `STATUS.md` |

## Phase 6 — Build (by ticket type)

| Ticket type | Primary skill | Also load role |
|-------------|---------------|----------------|
| SwiftUI UI | `swiftui-pro` | `engineer.md`, `execute-backlog-ticket` |
| async / actors | `swift-concurrency-pro` | `engineer.md` |
| SwiftData | `swiftdata-pro` | `engineer.md` |
| General iOS impl | `ios-dev-guide` | `engineer.md` |
| Any P0 | `execute-backlog-ticket` | enforces handoffs |

## Phase 7 — Alpha

| Skill | When | Output |
|-------|------|--------|
| — | `roles/engineer.md` + QA hat | `docs/QA.md` |

## Phase 8 — App Store (iOS only)

| Skill | When | Output |
|-------|------|--------|
| `app-store-release` | Orchestrate full release pass | audit + checklist |
| `apple-app-review` | Router for guideline checks | routes to agents/skills |
| `appstore-full-audit` | Full audit (agent file) | `docs/APPSTORE_AUDIT.md` |
| `app-store-connect` | ASC API upload/metadata (needs credentials) | ASC state |
| Targeted review | One of 31 skills below | section in `APPSTORE_AUDIT.md` |

### App Store review skills (invoke one at a time)

| Skill | Topic |
|-------|--------|
| `privacy-manifest-check` | PrivacyInfo.xcprivacy |
| `account-deletion-check` | Account deletion |
| `privacy-policy-check` | Policy URL |
| `att-framework-audit` | ATT / tracking |
| `request-timing-audit` | Permission at launch |
| `usage-description-audit` | NSUsageDescription strings |
| `iap-compliance` | StoreKit / no bypass |
| `subscription-disclosure` | Subscription paywall |
| `sign-in-with-apple` | SIWA requirement |
| `ipad-layout-audit` | iPad layout |
| `dynamic-type-support` | Dynamic Type |
| `safe-area-compliance` | Safe area / notch |
| `crash-risk-audit` | Force unwrap / crashes |
| `app-completeness-check` | Lorem ipsum, placeholders |
| `review-readiness-check` | Version name, demo account |
| `screenshot-guidelines` | Screenshot content |
| `metadata-accuracy` | Description vs app |
| `ugc-safety-features` | Report / block UGC |
| `sdk-version-check` | Deprecated APIs |
| `push-notification-audit` | Push hygiene |
| `private-api-audit` | Private API |
| `background-execution-audit` | Background modes |
| `review-request-audit` | Review prompts |
| `ai-data-disclosure` | AI third-party data |
| `data-minimization-audit` | Data minimization |
| `permission-scope-audit` | Permission scope |
| `orientation-support` | Orientation |
| `app-name-compliance` | App name rules |
| `age-rating-accuracy` | Age rating |
| `loot-box-disclosure` | Loot boxes |
| `content-moderation-api` | Moderation API |

Agents (multi-skill audits): `.cursor/app-store-agents/` — `appstore-full-audit.md`, `ipad-layout-agent.md`, `privacy-audit-agent.md`, `permission-audit-agent.md`, `ugc-safety-agent.md`.

## Swift catalog (extra installs)

`swift-agent-skills` → read `external/swift-agent-skills/README.md` for links not vendored locally.

## Ensure skills exist in this repo

```bash
./scripts/install-agents.sh          # Lab App
./scripts/sync-project-skills.sh .   # refresh .cursor/skills
./scripts/sync-project-skills.sh ../MyApp   # copy to app
```

## STATUS.md template for Director

When assigning work, set in `docs/STATUS.md`:

```markdown
**Active skill:** `swiftui-pro`
**Subagent prompt:** Use roles/engineer.md and skill swiftui-pro. Ticket P0-2. Output: code + build note.
```
