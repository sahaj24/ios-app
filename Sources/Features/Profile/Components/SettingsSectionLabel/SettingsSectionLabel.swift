import SwiftUI

/// Small muted label above a group of settings.
struct SettingsSectionLabel: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.swFootnote)
            .foregroundColor(.swMuted)
            .padding(.leading, Spacing.s4)
            .padding(.top, Spacing.s4)
    }
}

#Preview {
    SettingsSectionLabel(title: "Practice")
        .padding()
        .screenBackground()
}
