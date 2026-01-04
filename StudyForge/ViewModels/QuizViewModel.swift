import Foundation
import Observation

@MainActor
@Observable
final class QuizViewModel {
    var questions: [QuizQuestionEntity]
    var selections: [UUID: UUID] = [:]

    private let haptics = HapticsManager()

    init(questions: [QuizQuestionEntity]) {
        self.questions = questions
    }

    func select(option: QuizOptionEntity, for question: QuizQuestionEntity) {
        selections[question.id] = option.id
        if option.isCorrect {
            haptics.notifySuccess()
        } else {
            haptics.notifyWarning()
        }
    }

    func selectedOption(for question: QuizQuestionEntity) -> QuizOptionEntity? {
        guard let optionId = selections[question.id] else { return nil }
        return question.options?.first { $0.id == optionId }
    }
}
