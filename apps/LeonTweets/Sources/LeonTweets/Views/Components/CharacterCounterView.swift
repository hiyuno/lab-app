import SwiftUI

struct CharacterCounterView: View {
    let count: Int
    let limit: Int

    var body: some View {
        Text("\(count) / \(limit)")
            .font(.caption)
            .monospacedDigit()
            .foregroundStyle(count > limit ? .red : .secondary)
    }
}
