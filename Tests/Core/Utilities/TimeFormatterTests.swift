import XCTest
@testable import Speakwell

final class TimeFormatterTests: XCTestCase {
    func testClockText() {
        XCTAssertEqual(TimeFormatter.clockText(seconds: 120), "2:00")
        XCTAssertEqual(TimeFormatter.clockText(seconds: 0), "0:00")
        XCTAssertEqual(TimeFormatter.clockText(seconds: 65), "1:05")
    }

    func testNegativeSecondsClampToZero() {
        XCTAssertEqual(TimeFormatter.clockText(seconds: -5), "0:00")
    }

    func testDurationText() {
        XCTAssertEqual(TimeFormatter.durationText(seconds: 120), "2 min")
        XCTAssertEqual(TimeFormatter.durationText(seconds: 90), "1 min 30 sec")
        XCTAssertEqual(TimeFormatter.durationText(seconds: 45), "45 sec")
        XCTAssertEqual(TimeFormatter.durationText(seconds: 600), "10 min")
    }

    func testLongDurationText() {
        XCTAssertEqual(TimeFormatter.longDurationText(seconds: 60), "1 minute")
        XCTAssertEqual(TimeFormatter.longDurationText(seconds: 120), "2 minutes")
        XCTAssertEqual(TimeFormatter.longDurationText(seconds: 90), "1 minute 30 seconds")
        XCTAssertEqual(TimeFormatter.longDurationText(seconds: 45), "45 seconds")
    }

    func testSummaryTextPadsSeconds() {
        XCTAssertEqual(TimeFormatter.summaryText(seconds: 120), "2 min 00 sec")
        XCTAssertEqual(TimeFormatter.summaryText(seconds: 30), "0 min 30 sec")
        XCTAssertEqual(TimeFormatter.summaryText(seconds: 900), "15 min 00 sec")
    }
}
