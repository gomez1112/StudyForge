import SwiftUI

struct GlassSurfaceModifier: ViewModifier {
    let cornerRadius: CGFloat
    let isInteractive: Bool

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .glassEffect(
                    isInteractive ? .regular.interactive() : .regular,
                    in: .rect(cornerRadius: cornerRadius, style: .continuous)
                )
        } else {
            content
                .background(.thinMaterial, in: .rect(cornerRadius: cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(.white.opacity(0.18))
                }
        }
    }
}

extension View {
    @ViewBuilder
    func glassSurface(cornerRadius: CGFloat = 20, isInteractive: Bool = false) -> some View {
        modifier(GlassSurfaceModifier(cornerRadius: cornerRadius, isInteractive: isInteractive))
    }

    @ViewBuilder
    func glassButtonStyle(isProminent: Bool = false) -> some View {
        if #available(iOS 26, *) {
            buttonStyle(isProminent ? .glassProminent : .glass)
        } else {
            buttonStyle(isProminent ? .borderedProminent : .bordered)
        }
    }
}
