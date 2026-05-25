# LeonTweets — Kickoff Pack

**Platform:** macOS
**Stack:** macos-swiftpm
**Date:** 2026-05-25

## Objective

macOS utility for fans of Mexican rock artist Leon Larregui.
The user pastes song lyrics, receives a poetic Spanish interpretation
from OpenAI ChatGPT, reviews it as a tweet (≤280 chars), and posts it
directly to X (Twitter). One focused flow, no distractions.

## Product guardrails

- This is NOT a general-purpose Twitter client.
- This is NOT a lyric database or music discovery app.
- No in-app purchases, subscriptions, or ads.
- All API keys are stored in macOS Keychain — never in source or UserDefaults.
- Output language is always Spanish (es).

## Out of scope (v1)

- Lyric database or search
- Multi-account X support
- Tweet scheduling
- Image/media attachments
- App Store distribution

## Tech constraints

- macOS 14+, Swift 6.0, SwiftUI, SwiftPM
- URLSession + async/await only (no third-party networking libs)
- CryptoKit for OAuth 1.0a HMAC-SHA1 signing
- No SwiftData in MVP (in-memory state only)
- App sandbox: `com.apple.security.network.client` required

## Definition of done (MVP)

- User can paste lyrics, receive a tweet draft, and post it to X.
- API keys stored and retrieved from Keychain (no plaintext secrets).
- App compiles with `swift build` on macOS 14+.
- `swift test` passes (TweetFormatter unit tests).
