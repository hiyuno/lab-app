import Combine
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var openAIKey: String = ""
    @Published var grokAPIKey: String = ""
    @Published var twitterAPIKey: String = ""
    @Published var twitterAPISecret: String = ""
    @Published var twitterAccessToken: String = ""
    @Published var twitterAccessTokenSecret: String = ""
    @Published var validationError: String?

    private var original: [String: String] = [:]

    var hasChanges: Bool {
        openAIKey != original["openAIKey"]
            || grokAPIKey != original["grokAPIKey"]
            || twitterAPIKey != original["twitterAPIKey"]
            || twitterAPISecret != original["twitterAPISecret"]
            || twitterAccessToken != original["twitterAccessToken"]
            || twitterAccessTokenSecret != original["twitterAccessTokenSecret"]
    }

    func load() async {
        let k = KeychainService.shared
        openAIKey = await k.load(.openAIKey) ?? ""
        grokAPIKey = await k.load(.grokAPIKey) ?? ""
        twitterAPIKey = await k.load(.twitterAPIKey) ?? ""
        twitterAPISecret = await k.load(.twitterAPISecret) ?? ""
        twitterAccessToken = await k.load(.twitterAccessToken) ?? ""
        twitterAccessTokenSecret = await k.load(.twitterAccessTokenSecret) ?? ""
        snapshot()
    }

    func save() async throws {
        validationError = nil

        // At least one AI key must be set
        if openAIKey.isEmpty && grokAPIKey.isEmpty {
            validationError = "Agrega al menos una API key de IA (OpenAI o Grok)."
            return
        }

        // All four Twitter fields must be set or all empty
        let twitterFields = [twitterAPIKey, twitterAPISecret, twitterAccessToken, twitterAccessTokenSecret]
        let filledCount = twitterFields.filter { !$0.isEmpty }.count
        if filledCount > 0 && filledCount < 4 {
            validationError = "Completa todos los campos de X (Twitter) o déjalos vacíos."
            return
        }

        let k = KeychainService.shared
        if !openAIKey.isEmpty {
            try await k.save(openAIKey, for: .openAIKey)
        } else {
            await k.delete(.openAIKey)
        }
        if !grokAPIKey.isEmpty {
            try await k.save(grokAPIKey, for: .grokAPIKey)
        } else {
            await k.delete(.grokAPIKey)
        }
        if !twitterAPIKey.isEmpty { try await k.save(twitterAPIKey, for: .twitterAPIKey) }
        if !twitterAPISecret.isEmpty { try await k.save(twitterAPISecret, for: .twitterAPISecret) }
        if !twitterAccessToken.isEmpty { try await k.save(twitterAccessToken, for: .twitterAccessToken) }
        if !twitterAccessTokenSecret.isEmpty { try await k.save(twitterAccessTokenSecret, for: .twitterAccessTokenSecret) }
        snapshot()
    }

    private func snapshot() {
        original = [
            "openAIKey": openAIKey,
            "grokAPIKey": grokAPIKey,
            "twitterAPIKey": twitterAPIKey,
            "twitterAPISecret": twitterAPISecret,
            "twitterAccessToken": twitterAccessToken,
            "twitterAccessTokenSecret": twitterAccessTokenSecret,
        ]
    }
}
