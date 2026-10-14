import SwiftUI

/// Small card with an icon, a label and a big number.
struct StatTile: View {
    let symbol: String
    let label: String
    let value: String

    var body: some View {
        GlassCard(radius: Radius.row) {
            VStack(alignment: .leading, spacing: Spacing.s8) {
                HStack(spacing: Spacing.s8) {
                    Image(systemName: symbol)
                    Text(label)
                }
                .font(.swSubheadline)
                .foregroundColor(.swMuted)
                Text(value)
                    .font(.swStat)
                    .foregroundColor(.swText)
            }
        }
    }
}

#Preview {
    StatTile(symbol: "waveform", label: "Sessions", value: "23")
        .padding()
        .screenBackground()
}
