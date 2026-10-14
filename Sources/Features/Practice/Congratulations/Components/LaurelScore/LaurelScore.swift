import SwiftUI

/// The big overall score flanked by green laurel branches.
/// The branches are Apple's `laurel.leading` / `laurel.trailing` SF Symbols,
/// matching the Figma design. The number counts up on appear.
struct LaurelScore: View {
    let score: Int

    var body: some View {
        HStack(spacing: Spacing.s8) {
            Image(systemName: "laurel.leading")
                .font(.system(size: Constants.Size.laurelSymbol))
                .foregroundColor(.swGreen)
            CountUpNumber(target: score)
                .font(.swScoreDisplay)
                .foregroundColor(.swText)
            Image(systemName: "laurel.trailing")
                .font(.system(size: Constants.Size.laurelSymbol))
                .foregroundColor(.swGreen)
        }
    }
}

#Preview {
    LaurelScore(score: 88)
        .padding()
        .screenBackground()
}
