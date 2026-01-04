import Foundation

enum TextExtractionError: LocalizedError {
    case invalidImage
    case emptyPDF

    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "We couldn't read that image. Try a clearer photo."
        case .emptyPDF:
            return "This PDF looks scanned. V1 supports selectable text PDFs; try a clearer export or paste text."
        }
    }
}
