import Combine
import Foundation

@MainActor
final class LyricsInputViewModel: ObservableObject {
    @Published var lyrics: String = ""
    @Published var isLoading: Bool = false
    @Published var error: APIError?

    @Published var searchQuery: String = ""
    @Published var searchResults: [SongResult] = []
    @Published var isSearching: Bool = false
    @Published var isFetchingLyrics: Bool = false

    @Published var provider: AIProvider {
        didSet { UserDefaults.standard.set(provider.rawValue, forKey: "aiProvider") }
    }
    @Published var lyricsSource: LyricsSource {
        didSet { UserDefaults.standard.set(lyricsSource.rawValue, forKey: "lyricsSource") }
    }

    init() {
        let savedProvider = UserDefaults.standard.string(forKey: "aiProvider") ?? ""
        provider = AIProvider(rawValue: savedProvider) ?? .chatGPT
        let savedSource = UserDefaults.standard.string(forKey: "lyricsSource") ?? ""
        lyricsSource = LyricsSource(rawValue: savedSource) ?? .genius
    }

    var canInterpret: Bool {
        !lyrics.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isLoading
    }

    // MARK: - AI interpretation

    func interpret() async -> String? {
        isLoading = true
        error = nil
        defer { isLoading = false }
        do {
            switch provider {
            case .chatGPT: return try await OpenAIClient.shared.interpret(lyrics: lyrics)
            case .grok: return try await GrokClient.shared.interpret(lyrics: lyrics)
            }
        } catch let e as APIError {
            self.error = e; return nil
        } catch {
            self.error = .networkFailure(error.localizedDescription); return nil
        }
    }

    // MARK: - Lyrics search

    func search() async {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return }
        isSearching = true
        error = nil
        defer { isSearching = false }
        do {
            switch lyricsSource {
            case .genius:
                searchResults = try await GeniusClient.shared.search(query: query)
            case .musixmatch:
                searchResults = try await MusixmatchClient.shared.search(query: query)
            }
        } catch let e as APIError {
            self.error = e
        } catch {
            self.error = .networkFailure(error.localizedDescription)
        }
    }

    func selectSong(_ song: SongResult) async {
        isFetchingLyrics = true
        error = nil
        defer { isFetchingLyrics = false }
        do {
            switch song.source {
            case .genius:
                lyrics = try await GeniusClient.shared.fetchLyrics(artist: song.artist, title: song.title)
            case .musixmatch:
                guard let trackID = song.musixmatchTrackID else { throw APIError.invalidResponse }
                lyrics = try await MusixmatchClient.shared.fetchLyrics(trackID: trackID)
            }
            searchResults = []
            searchQuery = ""
        } catch let e as APIError {
            self.error = e
        } catch {
            self.error = .networkFailure(error.localizedDescription)
        }
    }

    func clearSearch() {
        searchQuery = ""
        searchResults = []
        error = nil
    }
}
