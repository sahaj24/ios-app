import SwiftUI

/// Settings row with an icon, a title, an optional value and a chevron.
struct SettingsLinkRow: View {
    let symbol: String
    let title: String
    var value: String?

    var body: some View {
        HStack(spacing: Spacing.s12) {
            Image(systemName: symbol)
                .foregroundColor(.swText)
            Text(title)
                .font(.swBody)
                .foregroundColor(.swText)
            Spacer()
            if let value {
                Text(value)
                    .font(.swSubheadline)
                    .foregroundColor(.swMuted)
            }
            Image(systemName: "chevron.right")
                .font(.system(size: Constants.Size.chevron, weight: .semibold))
                .foregroundColor(.swMuted)
        }
        .padding(.horizontal, Spacing.cardPadding)
        .padding(.vertical, Spacing.s16)
    }
}

#Preview {
    SettingsLinkRow(symbol: "circle.lefthalf.filled", title: "Appearance", value: "System")
        .screenBackground()
}
