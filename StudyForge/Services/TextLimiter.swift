import Foundation

struct TextLimiter {
    let maxCharacters: Int

    init(maxCharacters: Int = 10_000) {
        self.maxCharacters = maxCharacters
    }

    func normalizeAndLimit(_ text: String) -> String {
        let normalized = text.split(whereSeparator: { $0.isWhitespace }).joined(separator: " ")
        guard normalized.count > maxCharacters else {
            return normalized
        }
        let index = normalized.index(normalized.startIndex, offsetBy: maxCharacters)
        return String(normalized[..<index])
    }
}
