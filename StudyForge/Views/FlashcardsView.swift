import SwiftUI

struct FlashcardsView: View {
    @State private var viewModel: FlashcardStudyViewModel

    init(cards: [FlashcardEntity]) {
        _viewModel = State(initialValue: FlashcardStudyViewModel(cards: cards))
    }

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.cards.isEmpty {
                ContentUnavailableView("No Flashcards", systemImage: "rectangle.on.rectangle")
            } else {
                FlashcardCardView(
                    front: viewModel.cards[viewModel.currentIndex].front,
                    back: viewModel.cards[viewModel.currentIndex].back,
                    isFlipped: viewModel.isFlipped
                )
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.isFlipped)

                HStack {
                    Button("Previous", systemImage: "chevron.left") {
                        viewModel.previous()
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button("Flip", systemImage: "arrow.2.circlepath") {
                        viewModel.flip()
                    }
                    .buttonStyle(.borderedProminent)

                    Spacer()

                    Button("Next", systemImage: "chevron.right") {
                        viewModel.next()
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding()
    }
}
