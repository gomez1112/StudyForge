import Foundation

enum GenerationError: LocalizedError {
    case safetyViolation
    case refusal(String)
    case unavailable(String)
    case generic(String)

    var errorDescription: String? {
        switch self {
        case .safetyViolation:
            return "The model flagged this request as unsafe. Try removing sensitive content."
        case .refusal(let message):
            return message
        case .unavailable(let message):
            return message
        case .generic(let message):
            return message
        }
    }
}
