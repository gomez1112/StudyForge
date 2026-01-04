import SwiftUI

struct SourceView: View {
    let sourceText: String
    let regenerate: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            CardSurface {
                VStack(alignment: .leading) {
                    Text("Source Text")
                        .font(.headline)

                    ScrollView {
                        Text(sourceText)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(minHeight: 240)
                }
            }

            Button("Regenerate", systemImage: "arrow.clockwise", action: regenerate)
                .glassButtonStyle(isProminent: true)
        }
        .padding()
    }
}
