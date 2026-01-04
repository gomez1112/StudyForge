import SwiftUI

struct MetricPillView: View {
    let title: String
    let value: Int
    let systemImage: String

    var body: some View {
        if #available(iOS 26, *) {
            Label {
                Text("\(value) \(title)")
            } icon: {
                Image(systemName: systemImage)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.horizontal)
            .padding(.vertical)
                .glassEffect(.regular, in: .capsule)
        } else {
            Label {
                Text("\(value) \(title)")
            } icon: {
                Image(systemName: systemImage)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.horizontal)
            .padding(.vertical)
                .background(.thinMaterial, in: .capsule)
        }
    }
}
