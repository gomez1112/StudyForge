import Foundation
import SwiftData

@Model
final class QuizOptionEntity {
    var id: UUID
    var label: String
    var text: String
    var isCorrect: Bool
    var question: QuizQuestionEntity?

    init(
        id: UUID = UUID(),
        label: String = "",
        text: String = "",
        isCorrect: Bool = false,
        question: QuizQuestionEntity? = nil
    ) {
        self.id = id
        self.label = label
        self.text = text
        self.isCorrect = isCorrect
        self.question = question
    }
}
