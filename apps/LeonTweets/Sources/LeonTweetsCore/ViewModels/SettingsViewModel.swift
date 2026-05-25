import Combine
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var openAIKey: String = ""
    @Published var twitterAPIKey: String = ""
    @Published var twitterAPISecret: String = ""
    @Published var twitterAccessToken: String = ""
    @Published var twitterAccessTokenSecret: String = ""
    @Published var validationError: String?

    private var original: [String: String] = [:]

    var hasChanges: Bool {
        openAIKey != original["openAIKey"]
            || twitterAPIKey != original["twitterAPIKey"]
            || twitterAPISecret != original["twitterAPISecret"]
            || twitterAccessToken != original["twitterAccessToken"]
            || twitterAccessTokenSecret != original["twitterAccessTokenSecret"]
    }

    func load() async {
        let k = KeychainService.shared
        openAIKey = await k.load(.openAIKey) ?? ""
        twitterAPIKey = await k.load(.twitterAPIKey) ?? ""
        twitterAPISecret = await k.load(.twitterAPISecret) ?? ""
        twitterAccessToken = await k.load(.twitterAccessToken) ?? ""
        twitterAccessTokenSecret = await k.load(.twitterAccessTokenSecret) ?? ""
        snapshot()
    }

    func save() async throws {
        validationError = nil
        let required: [(String, String)] = [
            (openAIKey, "OpenAI API Key"),
            (twitterAPIKey, "X API Key"),
            (twitterAPISecret, "X API Secret"),
            (twitterAccessToken, "X Access Token"),
            (twitterAccessTokenSecret, "X Access Token Secret"),
        ]
        if let missing = required.first(where: { $0.0.isEmpty }) {
            validationError = "\(missing.1) es requerido."
            return
        }
        let k = KeychainService.shared
        try await k.save(openAIKey, for: .openAIKey)
        try await k.save(twitterAPIKey, for: .twitterAPIKey)
        try await k.save(twitterAPISecret, for: .twitterAPISecret)
        try await k.save(twitterAccessToken, for: .twitterAccessToken)
        try await k.save(twitterAccessTokenSecret, for: .twitterAccessTokenSecret)
        snapshot()
    }

    private func snapshot() {
        original = [
            "openAIKey": openAIKey,
            "twitterAPIKey": twitterAPIKey,
            "twitterAPISecret": twitterAPISecret,
            "twitterAccessToken": twitterAccessToken,
            "twitterAccessTokenSecret": twitterAccessTokenSecret,
        ]
    }
}
