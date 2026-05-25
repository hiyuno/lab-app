struct TweetFormatter {
    static let maxLength = 280

    static func format(_ text: String) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count > maxLength else { return trimmed }
        let truncated = String(trimmed.prefix(maxLength - 1))
        if let lastSpace = truncated.lastIndex(of: " ") {
            return String(truncated[..<lastSpace]) + "…"
        }
        return String(trimmed.prefix(maxLength - 1)) + "…"
    }
}
