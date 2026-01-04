import Foundation

struct GenerationProgress: Equatable {
    var title: String
    var overview: String
    var flashcards: [FlashcardDraft]
    var quizQuestions: [QuizQuestionDraft]

    init(
        title: String = "",
        overview: String = "",
        flashcards: [FlashcardDraft] = [],
        quizQuestions: [QuizQuestionDraft] = []
    ) {
        self.title = title
        self.overview = overview
        self.flashcards = flashcards
        self.quizQuestions = quizQuestions
    }
}
