import Foundation
import FoundationModels

enum ModelAvailabilityStatus: Equatable {
    case available
    case appleIntelligenceUnavailable
    case downloading
    case deviceNotEligible
    case other(String)

    static func from(_ availability: SystemLanguageModel.Availability) -> ModelAvailabilityStatus {
        switch availability {
        case .available:
            return .available
        case .appleIntelligenceNotEnabled:
            return .appleIntelligenceUnavailable
        case .modelNotReady:
            return .downloading
        case .deviceNotEligible:
            return .deviceNotEligible
        @unknown default:
            return .other("The language model is currently unavailable.")
        }
    }
}
