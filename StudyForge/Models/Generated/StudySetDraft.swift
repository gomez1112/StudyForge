import Foundation
import FoundationModels

@Generable
struct StudySetDraft {
    @Guide("Short, student-friendly title derived from the source text.")
    var title: String

    @Guide("2–5 sentences summarizing the source text.")
    var overview: String

    @Guide("Flashcards with concise front/back prompts.")
    var flashcards: [FlashcardDraft]

    @Guide("Quiz questions with four labeled options and a short explanation.")
    var quizQuestions: [QuizQuestionDraft]
}
