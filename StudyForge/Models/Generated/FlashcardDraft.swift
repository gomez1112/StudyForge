import Foundation
import FoundationModels

@Generable
struct FlashcardDraft {
    @Guide("Front of the flashcard: a question, term, or prompt.")
    var front: String

    @Guide("Back of the flashcard: the answer or explanation.")
    var back: String
}
