import SwiftUI

/// Thin horizontal line. Bright by default (History rows), pass a softer color for cards.
struct SpeakwellDivider: View {
    var color: Color = .swDivider

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: Constants.Size.hairline)
    }
}

#Preview {
    SpeakwellDivider()
        .padding()
        .screenBackground()
}
