enum LyricsSource: String, CaseIterable, Sendable {
    case genius
    case musixmatch

    var displayName: String {
        switch self {
        case .genius: return "Genius"
        case .musixmatch: return "Musixmatch"
        }
    }
}
