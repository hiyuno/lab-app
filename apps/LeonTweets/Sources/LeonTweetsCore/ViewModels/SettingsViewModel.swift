import Combine
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    // AI
    @Published var openAIKey: String = ""
    @Published var grokAPIKey: String = ""
    // Lyrics
    @Published var geniusKey: String = ""
    @Published var musixmatchKey: String = ""
    // Twitter
    @Published var twitterAPIKey: String = ""
    @Published var twitterAPISecret: String = ""
    @Published var twitterAccessToken: String = ""
    @Published var twitterAccessTokenSecret: String = ""

    @Published var validationError: String?

    private var original: [String: String] = [:]

    var hasChanges: Bool {
        openAIKey != original["openAIKey"]
            || grokAPIKey != original["grokAPIKey"]
            || geniusKey != original["geniusKey"]
            || musixmatchKey != original["musixmatchKey"]
            || twitterAPIKey != original["twitterAPIKey"]
            || twitterAPISecret != original["twitterAPISecret"]
            || twitterAccessToken != original["twitterAccessToken"]
            || twitterAccessTokenSecret != original["twitterAccessTokenSecret"]
    }

    func load() async {
        let k = KeychainService.shared
        openAIKey = await k.load(.openAIKey) ?? ""
        grokAPIKey = await k.load(.grokAPIKey) ?? ""
        geniusKey = await k.load(.geniusKey) ?? ""
        musixmatchKey = await k.load(.musixmatchKey) ?? ""
        twitterAPIKey = await k.load(.twitterAPIKey) ?? ""
        twitterAPISecret = await k.load(.twitterAPISecret) ?? ""
        twitterAccessToken = await k.load(.twitterAccessToken) ?? ""
        twitterAccessTokenSecret = await k.load(.twitterAccessTokenSecret) ?? ""
        snapshot()
    }

    func save() async throws {
        validationError = nil

        if openAIKey.isEmpty && grokAPIKey.isEmpty {
            validationError = "Agrega al menos una API key de IA (OpenAI o Grok)."
            return
        }
        let twitterFields = [twitterAPIKey, twitterAPISecret, twitterAccessToken, twitterAccessTokenSecret]
        let filledCount = twitterFields.filter { !$0.isEmpty }.count
        if filledCount > 0 && filledCount < 4 {
            validationError = "Completa todos los campos de X (Twitter) o déjalos vacíos."
            return
        }

        let k = KeychainService.shared
        try await saveOrDelete(openAIKey, key: .openAIKey, client: k)
        try await saveOrDelete(grokAPIKey, key: .grokAPIKey, client: k)
        try await saveOrDelete(geniusKey, key: .geniusKey, client: k)
        try await saveOrDelete(musixmatchKey, key: .musixmatchKey, client: k)
        try await saveOrDelete(twitterAPIKey, key: .twitterAPIKey, client: k)
        try await saveOrDelete(twitterAPISecret, key: .twitterAPISecret, client: k)
        try await saveOrDelete(twitterAccessToken, key: .twitterAccessToken, client: k)
        try await saveOrDelete(twitterAccessTokenSecret, key: .twitterAccessTokenSecret, client: k)
        snapshot()
    }

    private func saveOrDelete(_ value: String, key: KeychainService.Key, client: KeychainService) async throws {
        if value.isEmpty {
            await client.delete(key)
        } else {
            try await client.save(value, for: key)
        }
    }

    private func snapshot() {
        original = [
            "openAIKey": openAIKey,
            "grokAPIKey": grokAPIKey,
            "geniusKey": geniusKey,
            "musixmatchKey": musixmatchKey,
            "twitterAPIKey": twitterAPIKey,
            "twitterAPISecret": twitterAPISecret,
            "twitterAccessToken": twitterAccessToken,
            "twitterAccessTokenSecret": twitterAccessTokenSecret,
        ]
    }
}
