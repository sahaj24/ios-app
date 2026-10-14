import XCTest
@testable import Speakwell

final class HistoryViewModelTests: XCTestCase {
    func testDefaultSegmentIsSessions() {
        XCTAssertEqual(HistoryViewModel().segment, .sessions)
    }

    func testSessionsComeFromProvider() {
        XCTAssertEqual(HistoryViewModel().sessions, SessionHistoryProvider.sessions)
    }

    func testSwitchToStreak() {
        let viewModel = HistoryViewModel()
        viewModel.segment = .streak
        XCTAssertEqual(viewModel.segment, .streak)
    }

    func testStreakStartsOnTheDesignWeek() {
        XCTAssertEqual(HistoryViewModel().selectedWeek, StreakProvider.initialWeekIndex)
    }

    func testWeekNavigationStopsAtBothEnds() {
        let viewModel = HistoryViewModel()
        for _ in 0..<10 { viewModel.showEarlierWeek() }
        XCTAssertEqual(viewModel.selectedWeek, 0)
        for _ in 0..<10 { viewModel.showNewerWeek() }
        XCTAssertEqual(viewModel.selectedWeek, viewModel.streak.weeks.count - 1)
    }
}
