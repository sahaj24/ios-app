import Foundation

final class HistoryViewModel: ObservableObject {
    @Published var segment: HistorySegment = .sessions
    /// Which week the Streak pager is showing (0 = oldest).
    @Published var selectedWeek: Int

    let sessions: [SessionSummary]
    let streak: StreakSummary

    init(
        sessions: [SessionSummary] = SessionHistoryProvider.sessions,
        streak: StreakSummary = StreakProvider.current,
        selectedWeek: Int = StreakProvider.initialWeekIndex
    ) {
        self.sessions = sessions
        self.streak = streak
        self.selectedWeek = selectedWeek
    }

    func showEarlierWeek() {
        selectedWeek = max(selectedWeek - 1, 0)
    }

    func showNewerWeek() {
        selectedWeek = min(selectedWeek + 1, streak.weeks.count - 1)
    }
}
