import Testing
@testable import LeonTweetsCore

@Suite("TweetFormatter")
struct TweetFormatterTests {

    @Test("input under 280 chars is returned unchanged")
    func underLimit() {
        let text = "El silencio es una forma de hablar sin palabras."
        #expect(TweetFormatter.format(text) == text)
    }

    @Test("input at exactly 280 chars is returned unchanged")
    func exactLimit() {
        let text = String(repeating: "a", count: 280)
        #expect(TweetFormatter.format(text) == text)
    }

    @Test("input over 280 chars is truncated with ellipsis and within limit")
    func overLimit() {
        let text = String(repeating: "palabra ", count: 40) // 320 chars
        let result = TweetFormatter.format(text)
        #expect(result.count <= 280)
        #expect(result.hasSuffix("…"))
    }

    @Test("truncation respects word boundary")
    func wordBoundary() {
        let text = String(repeating: "hola ", count: 60) // 300 chars
        let result = TweetFormatter.format(text)
        #expect(result.count <= 280)
        #expect(!result.dropLast().hasSuffix(" "))
    }

    @Test("empty string is returned as-is")
    func emptyInput() {
        #expect(TweetFormatter.format("") == "")
    }

    @Test("single character is returned as-is")
    func singleChar() {
        #expect(TweetFormatter.format("a") == "a")
    }

    @Test("leading and trailing whitespace is trimmed")
    func whitespaceTrimed() {
        let text = "  hola  "
        #expect(TweetFormatter.format(text) == "hola")
    }
}
