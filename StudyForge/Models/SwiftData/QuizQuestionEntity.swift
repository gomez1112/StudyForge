import Foundation
import SwiftData

@Model
final class QuizQuestionEntity {
    var id: UUID
    var prompt: String
    var explanation: String
    var orderIndex: Int
    var studySet: StudySetEntity?
    @Relationship(deleteRule: .cascade, inverse: \QuizOptionEntity.question)
    var options: [QuizOptionEntity]?

    init(
        id: UUID = UUID(),
        prompt: String = "",
        explanation: String = "",
        orderIndex: Int = 0,
        studySet: StudySetEntity? = nil,
        options: [QuizOptionEntity]? = []
    ) {
        self.id = id
        self.prompt = prompt
        self.explanation = explanation
        self.orderIndex = orderIndex
        self.studySet = studySet
        self.options = options
    }
}
