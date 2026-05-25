import LeonTweetsCore
import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var didSave = false

    var body: some View {
        Form {
            Section("OpenAI") {
                SecureField("API Key", text: $viewModel.openAIKey)
            }

            Section("X (Twitter) — OAuth 1.0a") {
                SecureField("API Key", text: $viewModel.twitterAPIKey)
                SecureField("API Secret", text: $viewModel.twitterAPISecret)
                SecureField("Access Token", text: $viewModel.twitterAccessToken)
                SecureField("Access Token Secret", text: $viewModel.twitterAccessTokenSecret)
            }

            if let error = viewModel.validationError {
                Section {
                    Label(error, systemImage: "exclamationmark.circle")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }

            if didSave {
                Section {
                    Label("Configuración guardada", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Guardar") {
                    Task {
                        try? await viewModel.save()
                        if viewModel.validationError == nil {
                            didSave = true
                            try? await Task.sleep(for: .seconds(2))
                            didSave = false
                        }
                    }
                }
                .disabled(!viewModel.hasChanges)
            }
        }
        .task { await viewModel.load() }
        .frame(width: 420, height: 400)
        .navigationTitle("Configuración de APIs")
    }
}
