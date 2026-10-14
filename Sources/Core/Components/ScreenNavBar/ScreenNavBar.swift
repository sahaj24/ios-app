import SwiftUI

/// Back button on the left, centered title, optional round button on the right.
struct ScreenNavBar: View {
    let title: String
    let onBack: () -> Void
    var trailingSymbol: String?
    var onTrailing: () -> Void = {}

    var body: some View {
        ZStack {
            Text(title)
                .font(.swHeadline)
                .foregroundColor(.swText)
            HStack {
                GlassCircleButton(systemName: "chevron.left", action: onBack)
                Spacer()
                if let trailingSymbol {
                    GlassCircleButton(systemName: trailingSymbol, action: onTrailing)
                }
            }
        }
        .frame(height: Constants.Size.glassButton)
        .padding(.top, Spacing.s4)
    }
}

#Preview {
    ScreenNavBar(title: "Speaking", onBack: {}, trailingSymbol: "captions.bubble")
        .padding()
        .screenBackground()
}
