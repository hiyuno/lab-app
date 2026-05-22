# __APP_NAME__ — App Store submission checklist

Use with [process/APPSTORE_AGENTS.md](https://github.com/hiyuno/lab-app/blob/main/process/APPSTORE_AGENTS.md) in Lab App.

## Before audit

- [ ] `docs/APPSTORE_AUDIT.md` completed (no open P0)
- [ ] `docs/QA.md` alpha pass done
- [ ] Release build succeeds (Archive / TestFlight)

## Apple Developer / ASC account

- [ ] App ID / bundle ID registered
- [ ] Agreements, tax, banking active (if paid app or IAP)
- [ ] App record exists in App Store Connect (create manually if first ship)

## Binary & Xcode

- [ ] Version and build number incremented
- [ ] App icon in asset catalog
- [ ] `PrivacyInfo.xcprivacy` present if using required-reason APIs
- [ ] No debug-only URLs or lorem ipsum in production paths
- [ ] Sign in with Apple (if third-party login)

## Privacy & legal

- [ ] Privacy policy URL live
- [ ] Support URL live
- [ ] In-app account deletion (if accounts exist)
- [ ] ATT flow if tracking (before analytics SDKs)
- [ ] App Privacy questionnaire completed in ASC (manual)

## Monetization (if applicable)

- [ ] IAP / subscriptions use StoreKit
- [ ] Subscription terms: price, renewal, trial end state visible
- [ ] No digital goods sold outside IAP without allowance

## Metadata & assets

- [ ] Screenshots show real app UI (6.7", 6.5", iPad if supported)
- [ ] Description matches shipped features
- [ ] Age rating accurate
- [ ] Review notes + demo account if login required

## TestFlight (optional)

- [ ] Internal test pass
- [ ] External beta if needed

## Submit

- [ ] Build uploaded and processed
- [ ] Export compliance answered
- [ ] Submitted for review
- [ ] `docs/STATUS.md` updated
