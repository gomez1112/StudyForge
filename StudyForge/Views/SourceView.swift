import SwiftUI

struct SourceView: View {
    let sourceText: String
    let regenerate: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Source Text")
                .font(.headline)

            ScrollView {
                Text(sourceText)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(minHeight: 240)
            .padding()
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 16, style: .continuous))

            Button("Regenerate", systemImage: "arrow.clockwise", action: regenerate)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
