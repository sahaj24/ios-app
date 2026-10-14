import SwiftUI

/// One line of the totals list: a muted label on the left, a bold value on the right.
struct StreakTotalRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.swSubheadline)
                .foregroundColor(.swMuted)
            Spacer()
            Text(value)
                .font(.swSubheadlineSemibold)
                .foregroundColor(.swText)
        }
        .frame(height: Constants.Size.streakTotalRow)
    }
}

#Preview {
    StreakTotalRow(label: "This month", value: "8 days")
        .padding()
        .screenBackground()
}
