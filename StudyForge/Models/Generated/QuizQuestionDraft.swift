import Foundation
import FoundationModels

@Generable
struct QuizQuestionDraft {
    @Guide("Question prompt based only on the source text.")
    var prompt: String

    @Guide("Exactly four options labeled A, B, C, D.")
    var options: [QuizOptionDraft]

    @Guide("The label (A/B/C/D) for the correct option.")
    var correctLabel: String

    @Guide("1–3 sentence explanation grounded in the source text.")
    var explanation: String
}
