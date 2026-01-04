import SwiftUI

struct EmptyStateView: View {
    let action: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("No Study Sets Yet", systemImage: "sparkles")
        } description: {
            Text("Capture notes, import PDFs, or paste text to build your first study set.")
        } actions: {
            Button("New Study Set", systemImage: "plus", action: action)
                .glassButtonStyle(isProminent: true)
        }
        .padding()
    }
}
