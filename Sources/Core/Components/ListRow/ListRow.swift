import SwiftUI

/// History row: icon circle, topic title, caption and chevron.
struct ListRow: View {
    let title: String
    let caption: String

    var body: some View {
        HStack(spacing: Spacing.s12) {
            Image(systemName: "waveform")
                .font(.swFootnoteSemibold)
                .foregroundColor(.swLavender)
                .frame(width: Constants.Size.iconCircle, height: Constants.Size.iconCircle)
                .background(Color.swIconCircle, in: Circle())
            VStack(alignment: .leading, spacing: Spacing.s4) {
                Text(title)
                    .font(.swBody)
                    .foregroundColor(.swText)
                Text(caption)
                    .font(.swFootnoteSemibold)
                    .foregroundColor(.swMuted)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: Constants.Size.chevron, weight: .semibold))
                .foregroundColor(.swMuted)
        }
    }
}

#Preview {
    ListRow(title: "Why curiosity matters", caption: "Yesterday · 2 min")
        .padding()
        .screenBackground()
}
