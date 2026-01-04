import SwiftUI

struct QuizOptionRowView: View {
    let option: QuizOptionEntity
    let isSelected: Bool
    let isCorrect: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(option.label)
                    .font(.headline)
                Text(option.text)
                    .foregroundStyle(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: isCorrect ? "checkmark.seal.fill" : "xmark.seal.fill")
                        .foregroundStyle(isCorrect ? .green : .red)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Option \(option.label): \(option.text)")
    }
}
