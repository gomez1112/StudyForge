import SwiftUI

struct ModelUnavailableView: View {
    let status: ModelAvailabilityStatus

    var body: some View {
        ContentUnavailableView {
            Label(titleText, systemImage: "brain")
        } description: {
            Text(messageText)
        }
        .padding()
    }

    private var titleText: String {
        switch status {
        case .appleIntelligenceUnavailable:
            return "Apple Intelligence is Off"
        case .downloading:
            return "Model Downloading"
        case .deviceNotEligible:
            return "Device Not Eligible"
        case .other:
            return "Model Unavailable"
        case .available:
            return ""
        }
    }

    private var messageText: String {
        switch status {
        case .appleIntelligenceUnavailable:
            return "Enable Apple Intelligence in Settings to generate study sets."
        case .downloading:
            return "The on-device model is still downloading. Check back in a few minutes."
        case .deviceNotEligible:
            return "This device cannot run on-device language models."
        case .other(let message):
            return message
        case .available:
            return ""
        }
    }
}
