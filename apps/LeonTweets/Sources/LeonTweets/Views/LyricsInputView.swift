import LeonTweetsCore
import SwiftUI

struct LyricsInputView: View {
    @ObservedObject var appViewModel: AppViewModel
    @StateObject private var viewModel = LyricsInputViewModel()

    var body: some View {
        VStack(spacing: 0) {
            searchBar
            if !viewModel.searchResults.isEmpty { searchResults }
            Divider()
            lyricsEditor
            if let error = viewModel.error {
                ErrorBannerView(message: error.localizedDescription) {
                    viewModel.error = nil
                }
            }
            Divider()
            bottomBar
        }
        .overlay { loadingOverlay }
        .navigationTitle("LeonTweets")
    }

    // MARK: - Subviews

    private var searchBar: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Buscar canción (Zoé, Leon Larregui…)", text: $viewModel.searchQuery)
                .textFieldStyle(.plain)
                .onSubmit { Task { await viewModel.search() } }

            if !viewModel.searchQuery.isEmpty {
                Button { viewModel.clearSearch() } label: {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }

            Picker("", selection: $viewModel.lyricsSource) {
                ForEach(LyricsSource.allCases, id: \.self) { src in
                    Text(src.displayName).tag(src)
                }
            }
            .labelsHidden()
            .fixedSize()

            Button("Buscar") { Task { await viewModel.search() } }
                .disabled(viewModel.searchQuery.trimmingCharacters(in: .whitespaces).isEmpty
                          || viewModel.isSearching)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }

    private var searchResults: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.searchResults) { song in
                    Button {
                        Task { await viewModel.selectSong(song) }
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(song.title)
                                    .font(.body)
                                    .foregroundStyle(.primary)
                                Text(song.artist)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text(song.source.displayName)
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .background(Color.primary.opacity(0.001))  // makes full row hittable
                    Divider().padding(.leading, 12)
                }
            }
        }
        .frame(maxHeight: 160)
        .background(.quaternary.opacity(0.3))
    }

    private var lyricsEditor: some View {
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
        .frame(minHeight: 180)
    }

    private var bottomBar: some View {
        HStack {
            Picker("", selection: $viewModel.provider) {
                ForEach(AIProvider.allCases, id: \.self) { p in
                    Text(p.displayName).tag(p)
                }
            }
            .pickerStyle(.segmented)
            .fixedSize()

            Spacer()

            Button("Interpretar") {
                Task {
                    if let result = await viewModel.interpret() {
                        appViewModel.navigate(to: .interpretation(result))
                    }
                }
            }
            .keyboardShortcut(.return, modifiers: .command)
            .disabled(!viewModel.canInterpret)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }

    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading || viewModel.isSearching || viewModel.isFetchingLyrics {
            let message: String = {
                if viewModel.isLoading { return "Interpretando con \(viewModel.provider.displayName)…" }
                if viewModel.isSearching { return "Buscando en \(viewModel.lyricsSource.displayName)…" }
                return "Cargando letra…"
            }()
            ZStack {
                Color.black.opacity(0.08)
                ProgressView(message)
                    .padding(20)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
