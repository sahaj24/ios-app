import SwiftUI

extension View {
    /// Liquid Glass background on iOS 26+, frosted material on older iOS.
    /// Use for floating controls (tab bar, nav buttons). Cards keep GlassCard.
    @ViewBuilder
    func glassSurface<S: InsettableShape>(in shape: S) -> some View {
        if #available(iOS 26, *) {
            glassEffect(.regular, in: shape)
        } else {
            background(.ultraThinMaterial, in: shape)
                .background(Color.swRaised.opacity(0.5), in: shape)
                .overlay(shape.strokeBorder(Color.swBorder, lineWidth: Constants.Size.hairline))
        }
    }
}
