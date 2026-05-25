import LeonTweetsCore
import SwiftUI

struct LyricsInputView: View {
    @ObservedObject var appViewModel: AppViewModel
    @StateObject private var viewModel = LyricsInputViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $viewModel.lyrics)
                    .font(.body)
                    .padding(8)

                if viewModel.lyrics.isEmpty {
                    Text("Pega aquí la letra de Leon Larregui…")
                        .foregroundStyle(.secondary)
                        .font(.body)
                        .padding(16)
                        .allowsHitTesting(false)
                }
            }
            .frame(minHeight: 220)

            if let error = viewModel.error {
                ErrorBannerView(message: error.localizedDescription) {
                    viewModel.error = nil
                }
            }

            Divider()

            HStack {
                Picker("", selection: $viewModel.provider) {
                    ForEach(AIProvider.allCases, id: \.self) { provider in
                        Text(provider.displayName).tag(provider)
                    }
                }
                .pickerStyle(.segmented)
                .fixedSize()

                Spacer()

                Button("Interpretar") {
                    Task {
                        if let interpretation = await viewModel.interpret() {
                            appViewModel.navigate(to: .interpretation(interpretation))
                        }
                    }
                }
                .keyboardShortcut(.return, modifiers: .command)
                .disabled(!viewModel.canInterpret)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.08)
                    ProgressView("Interpretando con \(viewModel.provider.displayName)…")
                        .padding(20)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .navigationTitle("LeonTweets")
    }
}
