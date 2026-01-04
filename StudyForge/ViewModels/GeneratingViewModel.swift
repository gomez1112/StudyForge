import Foundation
import Observation
import SwiftData
import FoundationModels

@MainActor
@Observable
final class GeneratingViewModel {
    var progress = GenerationProgress()
    var errorMessage: String?
    var isGenerating: Bool = false
    var completedStudySet: StudySetEntity?

    private let modelService = FoundationModelService()

    func startGeneration(context: GenerationContext, modelContext: ModelContext) {
        errorMessage = nil
        isGenerating = true
        progress = GenerationProgress()

        Task {
            do {
                var latestPartial: PartiallyGenerated<StudySetDraft>?
                for try await partial in modelService.streamStudySet(context: context) {
                    latestPartial = partial
                    progress = GenerationProgress(
                        title: partial.value?.title ?? progress.title,
                        overview: partial.value?.overview ?? progress.overview,
                        flashcards: partial.value?.flashcards ?? progress.flashcards,
                        quizQuestions: partial.value?.quizQuestions ?? progress.quizQuestions
                    )
                }

                guard let finalDraft = latestPartial?.value else {
                    throw GenerationError.generic("The model did not return a complete study set.")
                }

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
