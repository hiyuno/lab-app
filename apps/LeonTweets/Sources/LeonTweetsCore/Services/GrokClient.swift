import Foundation

actor GrokClient {
    static let shared = GrokClient()

    // xAI API is OpenAI-compatible; update model string as new versions release
    private let endpoint = URL(string: "https://api.x.ai/v1/chat/completions")!
    private let model = "grok-2-1212"

    private let systemPrompt = """
        Eres un poeta que interpreta letras de canciones de Leon Larregui. \
        Dado un fragmento de letra, escribe una interpretación poética y significativa en español, \
        en un párrafo corto (máximo 250 caracteres), como si fuera un tweet reflexivo. \
        Responde solo con el texto, sin explicaciones.
        """

    func interpret(lyrics: String) async throws -> String {
        guard let apiKey = await KeychainService.shared.load(.grokAPIKey) else {
            throw APIError.missingCredential("Grok API Key")
        }
        let body: [String: Any] = [
            "model": model,
            "messages": [
                ["role": "system", "content": systemPrompt],
                ["role": "user", "content": lyrics],
            ],
            "max_tokens": 150,
            "temperature": 0.8,
        ]
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.networkFailure(error.localizedDescription)
        }

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        switch http.statusCode {
        case 200: return try parseCompletion(from: data)
        case 401: throw APIError.unauthorized
        case 429: throw APIError.rateLimited
        default: throw APIError.invalidResponse
        }
    }

    private func parseCompletion(from data: Data) throws -> String {
        struct Response: Decodable {
            struct Choice: Decodable {
                struct Message: Decodable { let content: String }
                let message: Message
            }
            let choices: [Choice]
        }
        do {
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            guard let content = decoded.choices.first?.message.content else {
                throw APIError.invalidResponse
            }
            return content.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.decodingFailure(error.localizedDescription)
        }
    }
}
