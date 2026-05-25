import CryptoKit
import Foundation

actor TwitterClient {
    static let shared = TwitterClient()

    private let endpoint = URL(string: "https://api.twitter.com/2/tweets")!

    func post(tweet: String) async throws {
        let keychain = KeychainService.shared
        guard let apiKey = await keychain.load(.twitterAPIKey) else {
            throw APIError.missingCredential("X API Key")
        }
        guard let apiSecret = await keychain.load(.twitterAPISecret) else {
            throw APIError.missingCredential("X API Secret")
        }
        guard let accessToken = await keychain.load(.twitterAccessToken) else {
            throw APIError.missingCredential("X Access Token")
        }
        guard let accessTokenSecret = await keychain.load(.twitterAccessTokenSecret) else {
            throw APIError.missingCredential("X Access Token Secret")
        }

        let body = try JSONSerialization.data(withJSONObject: ["text": tweet])
        let authHeader = buildOAuth1Header(
            consumerKey: apiKey,
            consumerSecret: apiSecret,
            accessToken: accessToken,
            accessTokenSecret: accessTokenSecret
        )

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        let (_, response): (Data, URLResponse)
        do {
            (_, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.networkFailure(error.localizedDescription)
        }

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        switch http.statusCode {
        case 201: return
        case 401, 403: throw APIError.unauthorized
        case 429: throw APIError.rateLimited
        default: throw APIError.invalidResponse
        }
    }

    private func buildOAuth1Header(
        consumerKey: String,
        consumerSecret: String,
        accessToken: String,
        accessTokenSecret: String
    ) -> String {
        let nonce = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        let timestamp = String(Int(Date().timeIntervalSince1970))
        var params: [String: String] = [
            "oauth_consumer_key": consumerKey,
            "oauth_nonce": nonce,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_timestamp": timestamp,
            "oauth_token": accessToken,
            "oauth_version": "1.0",
        ]

        let paramString = params.sorted { $0.key < $1.key }
            .map { "\(rfc3986(\($0.key)))=\(rfc3986(\($0.value)))" }
            .joined(separator: "&")

        let baseString = "POST&\(rfc3986(endpoint.absoluteString))&\(rfc3986(paramString))"
        let signingKey = "\(rfc3986(consumerSecret))&\(rfc3986(accessTokenSecret))"
        params["oauth_signature"] = hmacSHA1(message: baseString, key: signingKey)

        let header = params
            .filter { $0.key.hasPrefix("oauth_") }
            .sorted { $0.key < $1.key }
            .map { "\(rfc3986($0.key))=\"\(rfc3986($0.value))\"" }
            .joined(separator: ", ")
        return "OAuth \(header)"
    }

    private func hmacSHA1(message: String, key: String) -> String {
        let symmetricKey = SymmetricKey(data: Data(key.utf8))
        let mac = HMAC<Insecure.SHA1>.authenticationCode(for: Data(message.utf8), using: symmetricKey)
        return Data(mac).base64EncodedString()
    }

    private func rfc3986(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved) ?? string
    }
}

private extension CharacterSet {
    static let rfc3986Unreserved = CharacterSet(
        charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
    )
}
