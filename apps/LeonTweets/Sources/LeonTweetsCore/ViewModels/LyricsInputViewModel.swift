import Combine
import Foundation

@MainActor
final class LyricsInputViewModel: ObservableObject {
    @Published var lyrics: String = ""
    @Published var isLoading: Bool = false
    @Published var error: APIError?

    var canInterpret: Bool {
        !lyrics.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isLoading
    }

    func interpret() async -> String? {
        isLoading = true
        error = nil
        defer { isLoading = false }
        do {
            return try await OpenAIClient.shared.interpret(lyrics: lyrics)
        } catch let apiError as APIError {
            self.error = apiError
            return nil
        } catch {
            self.error = .networkFailure(error.localizedDescription)
            return nil
        }
    }
}
