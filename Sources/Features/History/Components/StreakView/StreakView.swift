import SwiftUI

/// The History "Streak" segment: current and longest streak, a swipeable week
/// pager, practice totals and the next milestone.
struct StreakView: View {
    let summary: StreakSummary
    @Binding var selectedWeek: Int
    let onEarlier: () -> Void
    let onNewer: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s16) {
            StreakStatsHeader(currentText: summary.currentText, longestText: summary.longestText)
                .appearRise(index: 0)
            StreakWeekPager(
                weeks: summary.weeks,
                selection: $selectedWeek,
                onEarlier: onEarlier,
                onNewer: onNewer
            )
            .appearRise(index: 1)
            SpeakwellDivider(color: .swBorder)
            StreakTotals(thisMonthText: summary.thisMonthText, lastFourWeeksText: summary.lastFourWeeksText)
                .appearRise(index: 2)
            StreakMilestone(
                days: summary.milestoneDays,
                title: summary.milestoneTitle,
                detail: summary.milestoneDetail
            )
            .appearRise(index: 3)
        }
    }
}

#Preview {
    StreakView(
        summary: StreakProvider.current,
        selectedWeek: .constant(StreakProvider.initialWeekIndex),
        onEarlier: {},
        onNewer: {}
    )
    .padding()
    .screenBackground()
}
