import SwiftUI

/// "This month" and "Last four weeks" practice totals.
struct StreakTotals: View {
    let thisMonthText: String
    let lastFourWeeksText: String

    var body: some View {
        VStack(spacing: Spacing.sectionGap) {
            StreakTotalRow(label: "This month", value: thisMonthText)
            StreakTotalRow(label: "Last four weeks", value: lastFourWeeksText)
        }
    }
}

#Preview {
    StreakTotals(thisMonthText: "8 days", lastFourWeeksText: "21 days")
        .padding()
        .screenBackground()
}
