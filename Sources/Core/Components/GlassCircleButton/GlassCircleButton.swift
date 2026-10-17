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
                .glassSurface(in: Circle())
        }
        .buttonStyle(.speakwellPressable)
    }
}

#Preview {
    GlassCircleButton(systemName: "shuffle") {}
        .padding()
        .screenBackground()
}
