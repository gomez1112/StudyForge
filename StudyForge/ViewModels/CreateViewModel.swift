import Foundation
import Observation
import PhotosUI

@MainActor
@Observable
final class CreateViewModel {
    var title: String = ""
    var selectedInput: InputSourceType = .photo
    var photosPickerItem: PhotosPickerItem?
    var pdfURL: URL?
    var extractedText: String = ""
    var isExtracting: Bool = false
    var extractionError: String?
    var flashcardCount: Int = 8
    var quizCount: Int = 6

    private let extractionService = TextExtractionService()

    func handlePhotoSelection(_ item: PhotosPickerItem?) {
        guard let item else { return }
        isExtracting = true
        extractionError = nil
        Task {
            do {
                let text = try await extractionService.extractFromPhotoItem(item)
                extractedText = text
            } catch {
                extractionError = error.localizedDescription
            }
            isExtracting = false
        }
    }

    func handlePDFSelection(_ url: URL) {
        isExtracting = true
        extractionError = nil
        Task {
            do {
                let text = try await extractionService.extractFromPDF(url: url)
                extractedText = text
            } catch {
                extractionError = error.localizedDescription
            }
            isExtracting = false
        }
    }

    func handlePasteTextChange(_ text: String) {
        extractedText = extractionService.normalizeManualText(text)
    }

    func buildContext() -> GenerationContext? {
        let cleanedText = extractedText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedText.isEmpty else {
            return nil
        }
        let finalTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        return GenerationContext(
            title: finalTitle.isEmpty ? "New Study Set" : finalTitle,
            sourceText: cleanedText,
            flashcardCount: flashcardCount,
            quizCount: quizCount
        )
    }
}
