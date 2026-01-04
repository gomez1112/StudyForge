import Foundation
import FoundationModels

@Generable
struct QuizOptionDraft {
    @Guide("Label for the option: A, B, C, or D.")
    var label: String

    @Guide("Answer text for the option.")
    var text: String
}
