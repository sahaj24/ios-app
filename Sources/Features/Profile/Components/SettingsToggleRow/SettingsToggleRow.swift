import SwiftUI

/// Settings row with an icon, a title and a switch.
struct SettingsToggleRow: View {
    let symbol: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: Spacing.s12) {
            Image(systemName: symbol)
                .foregroundColor(.swText)
            Text(title)
                .font(.swBody)
                .foregroundColor(.swText)
            Spacer()
            Toggle(title, isOn: $isOn)
                .labelsHidden()
                .tint(.swLavender)
        }
        .padding(.horizontal, Spacing.cardPadding)
        .padding(.vertical, Spacing.s8)
    }
}

#Preview {
    SettingsToggleRow(symbol: "bell", title: "Daily reminder", isOn: .constant(false))
        .screenBackground()
}
