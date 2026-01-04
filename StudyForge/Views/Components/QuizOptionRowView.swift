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
            .glassSurface(cornerRadius: 16, isInteractive: true)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(isCorrect ? .green : .orange, lineWidth: 1)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Option \(option.label): \(option.text)")
    }
}
