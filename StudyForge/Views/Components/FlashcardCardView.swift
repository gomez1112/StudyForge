import SwiftUI

struct FlashcardCardView: View {
    let front: String
    let back: String
    let isFlipped: Bool

    var body: some View {
        CardSurface {
            VStack(alignment: .leading) {
                Text(isFlipped ? "Answer" : "Prompt")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(isFlipped ? back : front)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
}
