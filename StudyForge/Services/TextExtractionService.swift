import Foundation
import PhotosUI
import UIKit

struct TextExtractionService {
    private let ocrExtractor = OCRTextExtractor()
    private let pdfExtractor = PDFTextExtractor()
    private let limiter = TextLimiter()

    func extractFromPhotoItem(_ item: PhotosPickerItem) async throws -> String {
        let data = try await item.loadTransferable(type: Data.self)
        guard let data, let image = UIImage(data: data) else {
            throw TextExtractionError.invalidImage
        }
        let text = try await ocrExtractor.extractText(from: image)
        return limiter.normalizeAndLimit(text)
    }

    func extractFromPDF(url: URL) async throws -> String {
        let text = try await pdfExtractor.extractText(from: url)
        let normalized = limiter.normalizeAndLimit(text)
        if normalized.isEmpty {
            throw TextExtractionError.emptyPDF
        }
        return normalized
    }

    func normalizeManualText(_ text: String) -> String {
        limiter.normalizeAndLimit(text)
    }
}
