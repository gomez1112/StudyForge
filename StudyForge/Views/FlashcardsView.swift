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
                StudyProgressHeaderView(
                    title: "Flashcards",
                    subtitle: "Flip through key ideas and definitions.",
                    progress: Double(viewModel.currentIndex + 1) / Double(viewModel.cards.count),
                    detail: "Card \(viewModel.currentIndex + 1) of \(viewModel.cards.count)"
                )

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
                    .glassButtonStyle()

                    Spacer()

                    Button("Flip", systemImage: "arrow.2.circlepath") {
                        viewModel.flip()
                    }
                    .glassButtonStyle(isProminent: true)

                    Spacer()

                    Button("Next", systemImage: "chevron.right") {
                        viewModel.next()
                    }
                    .glassButtonStyle()
                }
            }
        }
        .padding()
    }
}
