import Foundation
import Observation

@MainActor
@Observable
final class FlashcardStudyViewModel {
    var cards: [FlashcardEntity]
    var currentIndex: Int = 0
    var isFlipped: Bool = false

    private let haptics = HapticsManager()

    init(cards: [FlashcardEntity]) {
        self.cards = cards
    }

    func flip() {
        isFlipped.toggle()
        haptics.notifySuccess()
    }

    func next() {
        guard !cards.isEmpty else { return }
        currentIndex = min(currentIndex + 1, cards.count - 1)
        isFlipped = false
    }

    func previous() {
        guard !cards.isEmpty else { return }
        currentIndex = max(currentIndex - 1, 0)
        isFlipped = false
    }
}
