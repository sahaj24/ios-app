import SwiftUI

/// Card row with a title, a muted subtitle and a chevron.
struct NavigationRowCard: View {
    let title: String
    let subtitle: String

    var body: some View {
        GlassCard(radius: Radius.row) {
            HStack {
                VStack(alignment: .leading, spacing: Spacing.s4) {
                    Text(title)
                        .font(.swHeadline)
                        .foregroundColor(.swText)
                    Text(subtitle)
                        .font(.swFootnote)
                        .foregroundColor(.swMuted)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: Constants.Size.chevron, weight: .semibold))
                    .foregroundColor(.swMuted)
            }
        }
    }
}

#Preview {
    NavigationRowCard(title: "Filler words", subtitle: "7 filler words in this speech")
        .padding()
        .screenBackground()
}
