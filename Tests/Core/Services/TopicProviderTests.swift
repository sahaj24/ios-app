import XCTest
@testable import Speakwell

final class TopicProviderTests: XCTestCase {
    func testDefaultTopic() {
        XCTAssertEqual(TopicProvider.defaultTopic.title, "Is social media bringing us closer?")
    }

    func testRandomTopicIsDifferentFromCurrent() {
        let current = TopicProvider.defaultTopic
        for _ in 0..<50 {
            XCTAssertNotEqual(TopicProvider.randomTopic(excluding: current), current)
        }
    }
}
