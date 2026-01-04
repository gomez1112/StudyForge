import Foundation
import FoundationModels

struct FoundationModelService {
    private let instructions = """
    You are StudyForge. Use ONLY the provided source text. Do not invent facts.
    If the source text lacks required info, say so briefly in the overview or explanation.
    Keep language concise, student-friendly, and grounded. Never include private data.
    """

    func availabilityStatus() -> ModelAvailabilityStatus {
        ModelAvailabilityStatus.from(SystemLanguageModel.default.availability)
    }

    func streamStudySet(context: GenerationContext) -> AsyncThrowingStream<PartiallyGenerated<StudySetDraft>, Error> {
        AsyncThrowingStream { continuation in
            Task {
                let availability = availabilityStatus()
                guard availability == .available else {
                    let message = availabilityMessage(for: availability)
                    continuation.finish(throwing: GenerationError.unavailable(message))
                    return
                }

                let prompt = """
                Source text:
                \(context.sourceText)

                Create a study set with \(context.flashcardCount) flashcards and \(context.quizCount) quiz questions.
                """

                let session = LanguageModelSession(model: SystemLanguageModel.default, instructions: instructions)

                do {
                    for try await partial in session.streamResponse(generating: StudySetDraft.self, prompt: prompt) {
                        continuation.yield(partial)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: mapError(error))
                }
            }
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
