import Foundation
import SwiftData

@Model
final class StudySetEntity {
    var id: UUID
    var title: String
    var overview: String
    var sourceText: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade, inverse: \FlashcardEntity.studySet)
    var flashcards: [FlashcardEntity]?
    @Relationship(deleteRule: .cascade, inverse: \QuizQuestionEntity.studySet)
    var quizQuestions: [QuizQuestionEntity]?

    init(
        id: UUID = UUID(),
        title: String = "",
        overview: String = "",
        sourceText: String = "",
        createdAt: Date = .now,
        flashcards: [FlashcardEntity]? = [],
        quizQuestions: [QuizQuestionEntity]? = []
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.sourceText = sourceText
        self.createdAt = createdAt
        self.flashcards = flashcards
        self.quizQuestions = quizQuestions
    }
}
