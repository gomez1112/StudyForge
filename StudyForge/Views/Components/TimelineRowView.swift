import SwiftUI

struct TimelineRowView: View {
    let title: String
    let subtitle: String
    let isComplete: Bool

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: isComplete ? "checkmark.circle.fill" : "circle.dotted")
                .font(.title3)
                .foregroundStyle(isComplete ? .green : .secondary)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 16, style: .continuous))
    }
}
