import LeonTweetsCore
import SwiftUI

struct InterpretationView: View {
    let interpretation: String
    @ObservedObject var appViewModel: AppViewModel
    @StateObject private var viewModel: InterpretationViewModel

    init(interpretation: String, appViewModel: AppViewModel) {
        self.interpretation = interpretation
        self.appViewModel = appViewModel
        _viewModel = StateObject(
            wrappedValue: InterpretationViewModel(interpretation: interpretation)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Text(viewModel.interpretation)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .frame(minHeight: 110)
            .background(.quaternary.opacity(0.4))

            Divider()

            VStack(alignment: .trailing, spacing: 4) {
                TextEditor(text: $viewModel.draft.text)
                    .font(.body)
                    .frame(minHeight: 100)
                    .padding(8)

                CharacterCounterView(
                    count: viewModel.draft.characterCount,
                    limit: 280
                )
                .padding(.horizontal, 12)
                .padding(.bottom, 4)
            }

            if let error = viewModel.error {
                ErrorBannerView(message: error.localizedDescription) {
                    viewModel.error = nil
                }
            }

            Divider()

            HStack {
                Button("← Volver") {
                    appViewModel.navigationPath.removeLast()
                }
                .buttonStyle(.borderless)

                Spacer()

                Button("Publicar") {
                    Task { await viewModel.post() }
                }
                .disabled(!viewModel.canPost)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .overlay {
            if viewModel.isPosting {
                ZStack {
                    Color.black.opacity(0.08)
                    ProgressView("Publicando…")
                        .padding(20)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
            }

            if viewModel.didPost {
                successHUD
            }
        }
        .navigationTitle("Tu Tweet")
    }

    private var successHUD: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 52))
                .foregroundStyle(.green)
            Text("¡Tweet publicado!")
                .font(.headline)
        }
        .padding(36)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
        .task {
            try? await Task.sleep(for: .seconds(2))
            appViewModel.reset()
        }
    }
}
