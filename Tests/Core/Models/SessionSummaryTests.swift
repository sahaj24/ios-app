import XCTest
@testable import Speakwell

final class SessionSummaryTests: XCTestCase {
    func testCaption() {
        let session = SessionSummary(id: 1, topicTitle: "Topic", dayLabel: "Today", minutes: 2)
        XCTAssertEqual(session.caption, "Today · 2 min")
    }
}
