struct SongResult: Identifiable, Sendable {
    let id: String
    let title: String
    let artist: String
    let source: LyricsSource
    let musixmatchTrackID: Int?
}
