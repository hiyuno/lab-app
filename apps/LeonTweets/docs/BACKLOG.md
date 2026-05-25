# LeonTweets — Backlog

## P0 — Must-have (MVP)

### P0-1  KeychainService
**Goal:** Store and retrieve API credentials securely via macOS Keychain.

**Status:** ✅ Done

**Acceptance criteria:**
- [x] `KeychainService.save(_:for:)` writes a secret using `SecItemAdd`.
- [x] `KeychainService.load(_:)` returns the stored secret or nil.
- [x] `KeychainService.delete(_:)` removes the item cleanly.
- [x] Saving a duplicate key updates (not duplicates) the existing entry.
- [x] No secret ever appears in `UserDefaults` or any .plist on disk.
- [x] Implemented as `actor` for Swift 6 concurrency safety.

---

### P0-2  SettingsView — API key entry
**Goal:** User can enter and persist their OpenAI and X credentials.

**Status:** ✅ Done

**Acceptance criteria:**
- [x] Settings screen opens via ⌘, (macOS Settings scene).
- [x] Five secure fields: OpenAI Key, X API Key, X API Secret, X Access Token, X Access Token Secret.
- [x] Saving calls `KeychainService.save` for each field.
- [x] Fields pre-populate from Keychain on open (masked display).
- [x] "Guardar" button is disabled when no field has changed.
- [x] Empty required field shows inline validation message (does not save).

---

### P0-3  OpenAIClient
**Goal:** Send lyrics to ChatGPT and receive a poetic Spanish interpretation.

**Status:** ✅ Done

**Acceptance criteria:**
- [x] `OpenAIClient.interpret(lyrics:) async throws -> String` calls `gpt-4o`.
- [x] System prompt instructs GPT to reply in Spanish, ≤250 chars, poetically.
- [x] API key is read from Keychain at call time.
- [x] `URLSession` only; no third-party networking libraries.
- [x] Typed `APIError` enum (.unauthorized, .rateLimited, .networkFailure, .missingCredential).
- [x] Missing key throws `APIError.missingCredential`.

---

### P0-4  TweetFormatter
**Goal:** Trim GPT output to ≤280 characters, respecting word boundaries.

**Status:** ✅ Done

**Acceptance criteria:**
- [x] `TweetFormatter.format(_ text: String) -> String` returns ≤280 chars.
- [x] If input ≤280 chars, output equals input (trimmed of whitespace).
- [x] If input >280 chars, output ends with `…` and is ≤280 chars.
- [x] Truncation ends on a word boundary.
- [x] Unit tests cover: under limit, exact 280, over 280, word boundary, empty, single char, whitespace.

---

### P0-5  LyricsInputView
**Goal:** Main screen where user pastes or types lyrics and triggers interpretation.

**Status:** ✅ Done

**Acceptance criteria:**
- [x] Multi-line `TextEditor` with placeholder "Pega aquí la letra de Leon Larregui…".
- [x] "Interpretar" button is disabled when field is empty.
- [x] Pressing "Interpretar" shows a spinner overlay.
- [x] On success, navigates to InterpretationView.
- [x] On error, shows `ErrorBannerView` with Spanish message.
- [x] Keyboard shortcut ⌘↩ triggers "Interpretar".

---

### P0-6  InterpretationView + TweetPreviewView
**Goal:** Show interpretation alongside editable tweet draft with live character counter.

**Status:** ✅ Done

**Acceptance criteria:**
- [x] Interpretation text shown read-only (scrollable).
- [x] Tweet draft field is editable, pre-filled with `TweetFormatter.format(interpretation)`.
- [x] Live `N / 280` counter; turns red when N > 280.
- [x] "Publicar" disabled when draft > 280 chars or empty.
- [x] Pressing "Publicar" calls `TwitterClient.post(tweet:)`.
- [x] On success, shows "¡Tweet publicado!" HUD, then resets to LyricsInputView after 2s.
- [x] On error, shows `ErrorBannerView` in Spanish.
- [x] "← Volver" returns to LyricsInputView.

---

### P0-7  TwitterClient
**Goal:** Post a tweet via `POST https://api.twitter.com/2/tweets` with OAuth 1.0a.

**Status:** ✅ Done

**Acceptance criteria:**
- [x] `TwitterClient.post(tweet:) async throws` POSTs `{"text": tweet}`.
- [x] OAuth 1.0a `Authorization` header computed in Swift using CryptoKit HMAC-SHA1.
- [x] Credentials read from Keychain at call time.
- [x] Missing credential throws `APIError.missingCredential`.
- [x] HTTP 201 → success. HTTP 401/403 → `.unauthorized`. HTTP 429 → `.rateLimited`.
- [x] `URLSession` only; no third-party OAuth libraries.

---

## P1 — Should-have (post-MVP)

- **P1-1** Tweet history: store posted text + timestamp locally (SwiftData).
- **P1-2** GPT streaming: stream tokens and update preview live.
- **P1-3** OAuth 2.0 PKCE: replace OAuth 1.0a for users with newer X API credentials.
- **P1-4** Dark mode polish.

## P2 — Later

- Multiple X accounts
- Share sheet integration
- App Store submission (needs entitlement + privacy review)
