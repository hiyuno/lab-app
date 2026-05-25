public enum AIProvider: String, CaseIterable, Sendable {
    case chatGPT = "chatgpt"
    case grok = "grok"

    public var displayName: String {
        switch self {
        case .chatGPT: return "ChatGPT"
        case .grok: return "Grok"
        }
    }
}
