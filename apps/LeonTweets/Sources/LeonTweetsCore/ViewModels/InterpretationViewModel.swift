import Combine
import Foundation

@MainActor
final class InterpretationViewModel: ObservableObject {
    @Published var interpretation: String
    @Published var draft: TweetDraft
    @Published var isPosting: Bool = false
    @Published var error: APIError?
    @Published var didPost: Bool = false

    init(interpretation: String) {
        self.interpretation = interpretation
        self.draft = TweetDraft(text: TweetFormatter.format(interpretation))
    }

    var canPost: Bool { draft.isValid && !isPosting }

    func post() async {
        isPosting = true
        error = nil
        defer { isPosting = false }
        do {
            try await TwitterClient.shared.post(tweet: draft.text)
            didPost = true
        } catch let apiError as APIError {
            self.error = apiError
        } catch {
            self.error = .networkFailure(error.localizedDescription)
        }
    }
}
