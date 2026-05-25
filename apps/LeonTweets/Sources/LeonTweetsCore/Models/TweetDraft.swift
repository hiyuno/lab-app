struct TweetDraft: Sendable {
    var text: String

    var characterCount: Int { text.count }
    var isValid: Bool { !text.isEmpty && characterCount <= 280 }
}
