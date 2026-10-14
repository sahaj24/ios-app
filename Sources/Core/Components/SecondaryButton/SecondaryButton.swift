import SwiftUI

/// Dark glass pill button (Retry, View analysis).
struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.swHeadline)
                .foregroundColor(.swText)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.Size.primaryButton)
                .background(Color.swSecondaryButton, in: Capsule())
                .overlay(Capsule().strokeBorder(Color.swBorder, lineWidth: Constants.Size.hairline))
        }
        .buttonStyle(.speakwellPressable)
    }
}

#Preview {
    SecondaryButton(title: "Retry") {}
        .padding()
        .screenBackground()
}
