import Combine
import Foundation

@MainActor
final class AppViewModel: ObservableObject {
    enum Destination: Hashable {
        case interpretation(String)
    }

    @Published var navigationPath: [Destination] = []

    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }

    func reset() {
        navigationPath = []
    }
}
