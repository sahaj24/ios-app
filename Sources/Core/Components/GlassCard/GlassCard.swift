import SwiftUI

/// Rounded dark card with a subtle top-to-bottom gradient and a thin border.
struct GlassCard<Content: View>: View {
    private let padding: CGFloat
    private let radius: CGFloat
    private let content: Content

    init(
        padding: CGFloat = Spacing.cardPadding,
        radius: CGFloat = Radius.card,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.radius = radius
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [.swSurfaceHighlight, .swSurface],
                    startPoint: .top,
                    endPoint: .bottom
                ),
                in: RoundedRectangle(cornerRadius: radius, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(Color.swBorder, lineWidth: Constants.Size.hairline)
            )
    }
}

#Preview {
    GlassCard {
        Text("Hello")
            .foregroundColor(.swText)
    }
    .padding()
    .screenBackground()
}
