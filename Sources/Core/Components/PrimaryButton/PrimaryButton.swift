import SwiftUI

/// Big lavender pill button (Start, Ready to Speak, Done).
struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.swHeadline)
                .foregroundColor(.swInk)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.Size.primaryButton)
                .background(Color.swAccent, in: Capsule())
                .overlay(
                    Capsule().strokeBorder(
                        LinearGradient(
                            colors: [.swAccentHighlight, .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: Constants.Size.hairline
                    )
                )
        }
        .buttonStyle(.speakwellPressable)
    }
}

#Preview {
    PrimaryButton(title: "Start") {}
        .padding()
        .screenBackground()
}
