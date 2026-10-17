import Foundation

final class HistoryViewModel: ObservableObject {
    @Published var segment: HistorySegment = .sessions
    /// Which week the Streak pager is showing (0 = oldest).
    @Published var selectedWeek: Int

    @Published private(set) var sessions: [SessionSummary]
    /// Ids of sessions the user starred.
    @Published private(set) var favoriteIDs: Set<Int> = []
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

    // MARK: Session actions (swipe and long-press)

    func isFavorite(_ session: SessionSummary) -> Bool {
        favoriteIDs.contains(session.id)
    }

    func toggleFavorite(_ session: SessionSummary) {
        if favoriteIDs.contains(session.id) {
            favoriteIDs.remove(session.id)
        } else {
            favoriteIDs.insert(session.id)
        }
    }

    func delete(_ session: SessionSummary) {
        sessions.removeAll { $0.id == session.id }
        favoriteIDs.remove(session.id)
    }

    // MARK: Streak weeks

    func showEarlierWeek() {
        selectedWeek = max(selectedWeek - 1, 0)
    }

    func showNewerWeek() {
        selectedWeek = min(selectedWeek + 1, streak.weeks.count - 1)
    }
}
