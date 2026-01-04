import SwiftUI

struct CardSurface<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 20, style: .continuous))
    }
}
