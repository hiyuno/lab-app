import Foundation
import Security

actor KeychainService {
    static let shared = KeychainService()

    enum Key: String {
        case openAIKey = "mx.9866.leontweets.openai"
        case grokAPIKey = "mx.9866.leontweets.grok"
        case geniusKey = "mx.9866.leontweets.genius"
        case musixmatchKey = "mx.9866.leontweets.musixmatch"
        case twitterAPIKey = "mx.9866.leontweets.twitter.apikey"
        case twitterAPISecret = "mx.9866.leontweets.twitter.apisecret"
        case twitterAccessToken = "mx.9866.leontweets.twitter.accesstoken"
        case twitterAccessTokenSecret = "mx.9866.leontweets.twitter.accesstokensecret"
    }

    func save(_ value: String, for key: Key) throws {
        guard let data = value.data(using: .utf8) else { return }
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: key.rawValue,
            kSecValueData: data,
        ]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw APIError.networkFailure("Keychain error \(status)")
        }
    }

    func load(_ key: Key) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: key.rawValue,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8)
        else { return nil }
        return string
    }

    func delete(_ key: Key) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: key.rawValue,
        ]
        SecItemDelete(query as CFDictionary)
    }
}
