# LeonTweets — Architecture

**Stack:** macOS 14+, Swift 6.0, SwiftUI, SwiftPM (no Xcode project)

## Module map

```
Sources/
  LeonTweetsCore/          ← library target (testable)
    Models/
      APIError.swift        enum APIError: Error, Sendable
      LyricChunk.swift      struct LyricChunk: Sendable
      TweetDraft.swift      struct TweetDraft: Sendable
    Services/
      KeychainService.swift actor — SecItem CRUD
      OpenAIClient.swift    actor — URLSession + gpt-4o
      TwitterClient.swift   actor — URLSession + OAuth 1.0a
      TweetFormatter.swift  struct — static format() → ≤280 chars
    ViewModels/
      LyricsInputViewModel.swift    @MainActor ObservableObject
      InterpretationViewModel.swift @MainActor ObservableObject
      SettingsViewModel.swift       @MainActor ObservableObject

  LeonTweets/              ← executable target
    App/
      LeonTweetsApp.swift   @main, WindowGroup + Settings scene
      AppViewModel.swift    @MainActor ObservableObject, nav path
    Views/
      LyricsInputView.swift
      InterpretationView.swift
      SettingsView.swift
      Components/
        ErrorBannerView.swift
        CharacterCounterView.swift

Tests/
  LeonTweetsTests/
    TweetFormatterTests.swift   Swift Testing suite
```

## Key decisions

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Module split | `LeonTweetsCore` (library) + `LeonTweets` (executable) | Enables unit testing of services/VMs |
| OAuth for X | OAuth 1.0a (HMAC-SHA1 via CryptoKit) | Simpler for personal tool; avoids browser redirect |
| OpenAI model | `gpt-4o`, temperature 0.8, max_tokens 150 | Good poetic quality vs cost |
| Keychain isolation | `actor KeychainService` | Swift 6 concurrency-safe; serializes SecItem calls |
| No SwiftData | In-memory state only | MVP has zero persistent data beyond API keys |
| No third-party libs | URLSession + CryptoKit + Security | Sandbox-safe, no dependency resolution issues |

## Entitlements

File: `LeonTweets.entitlements`
- `com.apple.security.app-sandbox = true`
- `com.apple.security.network.client = true`

Note: entitlements require code signing to be enforced. For development
runs via `swift run`, sandbox is unenforced. Apply entitlements when
packaging for distribution.

## Navigation model

Single `WindowGroup` with `NavigationStack(path:)`. States:
1. `LyricsInputView` (root)
2. `.interpretation(String)` → `InterpretationView`

`AppViewModel.reset()` pops to root after successful post.

## API endpoints

- OpenAI: `POST https://api.openai.com/v1/chat/completions`
- X/Twitter: `POST https://api.twitter.com/2/tweets`

## Risks

- X API free tier: 1 post/15 min. Mitigated by `APIError.rateLimited` copy.
- OpenAI `gpt-4o` is paid. Missing key surfaced at request time.
- OAuth 1.0a is deprecated in newer X tiers → P1 ticket for OAuth 2.0 PKCE.
