import Foundation
import PDFKit

struct PDFTextExtractor {
    func extractText(from url: URL) async throws -> String {
        try await Task.detached(priority: .userInitiated) {
            guard let document = PDFDocument(url: url) else {
                return ""
            }

            let pageCount = document.pageCount
            var content = ""
            for index in 0..<pageCount {
                guard let page = document.page(at: index) else { continue }
                if let pageText = page.string {
                    content.append(pageText)
                    content.append("\n")
                }
            }
            return content
        }.value
    }
}
