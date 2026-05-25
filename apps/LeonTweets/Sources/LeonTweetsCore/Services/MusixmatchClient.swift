import Foundation

actor MusixmatchClient {
    static let shared = MusixmatchClient()

    private let base = URL(string: "https://api.musixmatch.com/ws/1.1")!
    private let copyrightMarker = "******* This Lyrics is NOT for Commercial use *******"

    // MARK: - Search

    func search(query: String) async throws -> [SongResult] {
        guard let apiKey = await KeychainService.shared.load(.musixmatchKey) else {
            throw APIError.missingCredential("Musixmatch API Key")
        }
        let url = base
            .appending(path: "track.search")
            .appending(queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page_size", value: "15"),
                URLQueryItem(name: "s_track_rating", value: "desc"),
                URLQueryItem(name: "apikey", value: apiKey),
            ])

        let (data, response): (Data, URLResponse)
        do { (data, response) = try await URLSession.shared.data(from: url) }
        catch { throw APIError.networkFailure(error.localizedDescription) }

        try checkStatus(response)
        return try parseSearch(data)
    }

    private func parseSearch(_ data: Data) throws -> [SongResult] {
        struct Root: Decodable {
            struct Message: Decodable {
                struct Header: Decodable { let status_code: Int }
                struct Body: Decodable {
                    struct Item: Decodable {
                        struct Track: Decodable {
                            let track_id: Int
                            let track_name: String
                            let artist_name: String
                        }
                        let track: Track
                    }
                    let track_list: [Item]
                }
                let header: Header
                let body: Body
            }
            let message: Message
        }
        do {
            let root = try JSONDecoder().decode(Root.self, from: data)
            guard root.message.header.status_code == 200 else { throw APIError.invalidResponse }
            return root.message.body.track_list.map { item in
                SongResult(
                    id: "musixmatch-\(item.track.track_id)",
                    title: item.track.track_name,
                    artist: item.track.artist_name,
                    source: .musixmatch,
                    musixmatchTrackID: item.track.track_id
                )
            }
        } catch let e as APIError {
            throw e
        } catch {
            throw APIError.decodingFailure(error.localizedDescription)
        }
    }

    // MARK: - Lyrics

    func fetchLyrics(trackID: Int) async throws -> String {
        guard let apiKey = await KeychainService.shared.load(.musixmatchKey) else {
            throw APIError.missingCredential("Musixmatch API Key")
        }
        let url = base
            .appending(path: "track.lyrics.get")
            .appending(queryItems: [
                URLQueryItem(name: "track_id", value: "\(trackID)"),
                URLQueryItem(name: "apikey", value: apiKey),
            ])

        let (data, response): (Data, URLResponse)
        do { (data, response) = try await URLSession.shared.data(from: url) }
        catch { throw APIError.networkFailure(error.localizedDescription) }

        try checkStatus(response)
        return try parseLyrics(data)
    }

    private func parseLyrics(_ data: Data) throws -> String {
        struct Root: Decodable {
            struct Message: Decodable {
                struct Header: Decodable { let status_code: Int }
                struct Body: Decodable {
                    struct Lyrics: Decodable { let lyrics_body: String }
                    let lyrics: Lyrics
                }
                let header: Header
                let body: Body
            }
            let message: Message
        }
        do {
            let root = try JSONDecoder().decode(Root.self, from: data)
            guard root.message.header.status_code == 200 else { throw APIError.invalidResponse }
            let raw = root.message.body.lyrics.lyrics_body
            let cleaned = raw.components(separatedBy: copyrightMarker).first ?? raw
            return cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch let e as APIError {
            throw e
        } catch {
            throw APIError.decodingFailure(error.localizedDescription)
        }
    }

    private func checkStatus(_ response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        switch http.statusCode {
        case 200: return
        case 401: throw APIError.unauthorized
        case 429: throw APIError.rateLimited
        default: throw APIError.invalidResponse
        }
    }
}

// MARK: - URL helpers

private extension URL {
    func appending(path: String) -> URL {
        appendingPathComponent(path)
    }
    func appending(queryItems: [URLQueryItem]) -> URL {
        var comps = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        comps.queryItems = (comps.queryItems ?? []) + queryItems
        return comps.url!
    }
}
