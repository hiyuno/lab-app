import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "app.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("__APP_NAME__")
                .font(.title2)
            Text("Scaffolded from Lab App")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
