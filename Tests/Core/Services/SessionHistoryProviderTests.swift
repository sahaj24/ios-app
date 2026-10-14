import XCTest
@testable import Speakwell

final class SessionHistoryProviderTests: XCTestCase {
    func testHasEnoughRows() {
        XCTAssertGreaterThanOrEqual(SessionHistoryProvider.sessions.count, 6)
    }

    func testNewestFirst() {
        XCTAssertEqual(SessionHistoryProvider.sessions.first?.caption, "Today · 2 min")
    }

    func testIdsAreUnique() {
        let ids = SessionHistoryProvider.sessions.map(\.id)
        XCTAssertEqual(Set(ids).count, ids.count)
    }
}
