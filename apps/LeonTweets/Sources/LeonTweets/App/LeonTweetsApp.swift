import SwiftUI

@main
struct LeonTweetsApp: App {
    @StateObject private var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appViewModel.navigationPath) {
                LyricsInputView(appViewModel: appViewModel)
                    .navigationDestination(for: AppViewModel.Destination.self) { destination in
                        switch destination {
                        case .interpretation(let text):
                            InterpretationView(interpretation: text, appViewModel: appViewModel)
                        }
                    }
            }
            .frame(minWidth: 520, minHeight: 400)
        }

        Settings {
            SettingsView()
        }
    }
}
