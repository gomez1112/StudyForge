import Foundation
import Observation
import SwiftData
import FoundationModels

@MainActor
@Observable
final class GeneratingViewModel {
    var errorMessage: String?
    var isGenerating: Bool = false
    var completedStudySet: StudySetEntity?

    private let modelService = FoundationModelService()

    var progress: GenerationProgress {
        modelService.progress
    }

    func startGeneration(context: GenerationContext, modelContext: ModelContext) {
        errorMessage = nil
        isGenerating = true
        modelService.reset()

        Task {
            do {
                try await modelService.suggestStudySet(context: context)

                let progress = modelService.progress
                guard !progress.title.isEmpty,
                      !progress.overview.isEmpty,
                      !progress.flashcards.isEmpty,
                      !progress.quizQuestions.isEmpty
                else {
                    throw GenerationError.generic("The model did not return a complete study set.")
                }

                let finalDraft = StudySetDraft(
                    title: progress.title,
                    overview: progress.overview,
                    flashcards: progress.flashcards,
                    quizQuestions: progress.quizQuestions
                )

                let studySet = mapToEntity(draft: finalDraft, context: context, modelContext: modelContext)
                completedStudySet = studySet
            } catch {
                errorMessage = error.localizedDescription
            }
            isGenerating = false
        }
    }

    private func mapToEntity(draft: StudySetDraft, context: GenerationContext, modelContext: ModelContext) -> StudySetEntity {
        let studySet = StudySetEntity(
            title: draft.title.isEmpty ? context.title : draft.title,
            overview: draft.overview,
            sourceText: context.sourceText
        )

        let flashcards = draft.flashcards.enumerated().map { index, card in
            FlashcardEntity(front: card.front, back: card.back, orderIndex: index, studySet: studySet)
        }

        let questions = draft.quizQuestions.enumerated().map { index, question in
            let questionEntity = QuizQuestionEntity(
                prompt: question.prompt,
                explanation: question.explanation,
                orderIndex: index,
                studySet: studySet
            )

            let options = question.options.map { option in
                QuizOptionEntity(
                    label: option.label,
                    text: option.text,
                    isCorrect: option.label == question.correctLabel,
                    question: questionEntity
                )
            }
            questionEntity.options = options
            return questionEntity
        }

        studySet.flashcards = flashcards
        studySet.quizQuestions = questions
        modelContext.insert(studySet)
        return studySet
    }
}
