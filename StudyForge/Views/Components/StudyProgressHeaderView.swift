import SwiftUI

struct StudyProgressHeaderView: View {
    let title: String
    let subtitle: String
    let progress: Double?
    let detail: String

    var body: some View {
        CardSurface {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2.bold())
                Text(subtitle)
                    .foregroundStyle(.secondary)
                if let progress {
                    ProgressView(value: progress)
                }
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
