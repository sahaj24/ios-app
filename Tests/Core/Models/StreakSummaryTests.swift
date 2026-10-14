import XCTest
@testable import Speakwell

final class StreakSummaryTests: XCTestCase {
    private let summary = StreakProvider.current

    func testTopStats() {
        XCTAssertEqual(summary.currentText, "5 days")
        XCTAssertEqual(summary.longestText, "8 days")
    }

    func testTotalsMatchTheDesign() {
        XCTAssertEqual(summary.thisMonthText, "8 days")
        XCTAssertEqual(summary.lastFourWeeksText, "21 days")
    }

    func testMilestoneIsOneDayBeyondTheRecord() {
        XCTAssertEqual(summary.milestoneDays, 9)
        XCTAssertEqual(summary.milestoneTitle, "9-day streak")
        XCTAssertEqual(summary.milestoneDetail, "4 more days to beat your longest streak.")
    }

    func testMilestoneWhenTheRecordIsTied() {
        let tied = StreakSummary(currentStreak: 8, longestStreak: 8, daysThisMonth: 8, weeks: [])
        XCTAssertEqual(tied.milestoneDetail, "1 more day to beat your longest streak.")
    }

    func testSingularDay() {
        let one = StreakSummary(currentStreak: 1, longestStreak: 1, daysThisMonth: 1, weeks: [])
        XCTAssertEqual(one.currentText, "1 day")
    }

    func testWeekCountsAndTitles() {
        let counts = summary.weeks.map(\.countText)
        XCTAssertEqual(counts, ["4/7 days", "6/7 days", "6/7 days", "5/7 days"])
        XCTAssertEqual(summary.weeks[StreakProvider.initialWeekIndex].title, "28 September–4 October")
    }

    func testEveryWeekHasSevenDays() {
        XCTAssertTrue(summary.weeks.allSatisfy { $0.days.count == 7 })
    }
}
