import SwiftUI

/// Round glass button holding one SF Symbol (back, shuffle, captions).
struct GlassCircleButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.swHeadline)
                .foregroundColor(.swText)
                .frame(width: Constants.Size.glassButton, height: Constants.Size.glassButton)
                .background(Color.swGlassButton, in: Circle())
                .overlay(Circle().strokeBorder(Color.swBorder, lineWidth: Constants.Size.hairline))
        }
        .buttonStyle(.speakwellPressable)
    }
}

#Preview {
    GlassCircleButton(systemName: "shuffle") {}
        .padding()
        .screenBackground()
}
