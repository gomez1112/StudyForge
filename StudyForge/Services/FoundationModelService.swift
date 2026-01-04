import Foundation
import FoundationModels
import Observation

@Observable
@MainActor
final class FoundationModelService {
    private let instructions = """
    You are StudyForge. Use ONLY the provided source text. Do not invent facts.
    If the source text lacks required info, say so briefly in the overview or explanation.
    Keep language concise, student-friendly, and grounded. Never include private data.
    """

    private(set) var studySet: StudySetDraft.PartiallyGenerated?
    private(set) var progress = GenerationProgress()
    private let session: LanguageModelSession

    var error: Error?

    init() {
        session = LanguageModelSession(
            model: SystemLanguageModel.default,
            instructions: instructions
        )
    }

    func availabilityStatus() -> ModelAvailabilityStatus {
        ModelAvailabilityStatus.from(SystemLanguageModel.default.availability)
    }

    func reset() {
        studySet = nil
        progress = GenerationProgress()
        error = nil
    }

    func suggestStudySet(context: GenerationContext) async throws {
        error = nil
        let availability = availabilityStatus()
        guard availability == .available else {
            let message = availabilityMessage(for: availability)
            let failure = GenerationError.unavailable(message)
            error = failure
            throw failure
        }

        let stream = session.streamResponse(
            generating: StudySetDraft.self,
            includeSchemaInPrompt: false
        ) {
            "Source text:"
            context.sourceText

            "Create a study set with \(context.flashcardCount) flashcards and \(context.quizCount) quiz questions."
        }

        do {
            for try await partialResponse in stream {
                let partialDraft = partialResponse.content
                studySet = partialDraft
                progress = GenerationProgress(
                    title: partialDraft?.title ?? progress.title,
                    overview: partialDraft?.overview ?? progress.overview,
                    flashcards: partialDraft?.flashcards ?? progress.flashcards,
                    quizQuestions: partialDraft?.quizQuestions ?? progress.quizQuestions
                )
            }
        } catch {
            let mappedError = mapError(error)
            self.error = mappedError
            throw mappedError
        }
    }

    private func availabilityMessage(for status: ModelAvailabilityStatus) -> String {
        switch status {
        case .available:
            return ""
        case .appleIntelligenceUnavailable:
            return "Apple Intelligence is not enabled on this device."
        case .downloading:
            return "The on-device model is downloading. Please try again soon."
        case .deviceNotEligible:
            return "This device is not eligible for on-device language models."
        case .other(let message):
            return message
        }
    }

    private func mapError(_ error: Error) -> GenerationError {
        let description = error.localizedDescription
        if description.localizedStandardContains("safety") {
            return .safetyViolation
        }
        if description.localizedStandardContains("refuse") {
            return .refusal("The model declined to answer. Try shortening or rephrasing the source text.")
        }
        return .generic(description)
    }
}
