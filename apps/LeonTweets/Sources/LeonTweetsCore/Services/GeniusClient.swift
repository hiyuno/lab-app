import Foundation

actor GeniusClient {
    static let shared = GeniusClient()

    private let searchBase = URL(string: "https://api.genius.com/search")!
    private let lyricsBase = "https://api.lyrics.ovh/v1"

    // MARK: - Search

    func search(query: String) async throws -> [SongResult] {
        guard let apiKey = await KeychainService.shared.load(.geniusKey) else {
            throw APIError.missingCredential("Genius API Key")
        }
        var comps = URLComponents(url: searchBase, resolvingAgainstBaseURL: false)!
        comps.queryItems = [URLQueryItem(name: "q", value: query)]
        var request = URLRequest(url: comps.url!)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, response): (Data, URLResponse)
        do { (data, response) = try await URLSession.shared.data(for: request) }
        catch { throw APIError.networkFailure(error.localizedDescription) }

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.unauthorized
        }
        return try parseSearch(data)
    }

    private func parseSearch(_ data: Data) throws -> [SongResult] {
        struct Root: Decodable {
            struct Body: Decodable {
                struct Hit: Decodable {
                    struct Song: Decodable {
                        let id: Int
                        let title: String
                        let artist_names: String
                    }
                    let type: String
                    let result: Song
                }
                let hits: [Hit]
            }
            let response: Body
        }
        do {
            let root = try JSONDecoder().decode(Root.self, from: data)
            return root.response.hits
                .filter { $0.type == "song" }
                .map {
                    SongResult(
                        id: "genius-\($0.result.id)",
                        title: $0.result.title,
                        artist: $0.result.artist_names,
                        source: .genius,
                        musixmatchTrackID: nil
                    )
                }
        } catch {
            throw APIError.decodingFailure(error.localizedDescription)
        }
    }

    // MARK: - Lyrics (via lyrics.ovh — no scraping needed)

    func fetchLyrics(artist: String, title: String) async throws -> String {
        var comps = URLComponents(string: lyricsBase)!
        comps.path = "/v1/\(artist)/\(title)"
        guard let url = comps.url else { throw APIError.invalidResponse }

        let (data, response): (Data, URLResponse)
        do { (data, response) = try await URLSession.shared.data(from: url) }
        catch { throw APIError.networkFailure(error.localizedDescription) }

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        struct LyricsOVH: Decodable {
            let lyrics: String?
            let error: String?
        }
        do {
            let decoded = try JSONDecoder().decode(LyricsOVH.self, from: data)
            if let err = decoded.error { throw APIError.networkFailure(err) }
            guard let text = decoded.lyrics, !text.isEmpty else { throw APIError.invalidResponse }
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch let e as APIError {
            throw e
        } catch {
            throw APIError.decodingFailure(error.localizedDescription)
        }
    }
}
