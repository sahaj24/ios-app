import XCTest
@testable import Speakwell

final class TopicProviderTests: XCTestCase {
    // MARK: Data from DebateTopics.swift

    func testHasTwentyCategoriesOfOneHundredTopics() {
        XCTAssertEqual(TopicProvider.categories.count, 20)
        XCTAssertTrue(TopicProvider.categories.allSatisfy { $0.topics.count == 100 })
        XCTAssertEqual(TopicProvider.allTopics.count, 2000)
    }

    func testTopicIdsAreUniqueAndTitlesAreNotEmpty() {
        let ids = Set(TopicProvider.allTopics.map(\.id))
        XCTAssertEqual(ids.count, 2000)
        XCTAssertTrue(TopicProvider.allTopics.allSatisfy { !$0.title.isEmpty })
    }

    func testCategoriesUseDisplayTitles() {
        XCTAssertEqual(TopicProvider.categories.first?.title, "Geopolitics and International Relations")
        XCTAssertTrue(TopicProvider.categories.allSatisfy { $0.title != $0.id })
    }

    func testEveryTopicPointsAtItsCategory() {
        for category in TopicProvider.categories {
            XCTAssertTrue(category.topics.allSatisfy { $0.categoryID == category.id })
        }
        let topic = TopicProvider.allTopics[150]
        XCTAssertEqual(TopicProvider.category(for: topic)?.id, topic.categoryID)
    }

    // MARK: Random

    func testRandomTopicIsDifferentFromCurrent() {
        let current = TopicProvider.defaultTopic
        for _ in 0..<50 {
            XCTAssertNotEqual(TopicProvider.randomTopic(excluding: current), current)
        }
    }

    func testRandomTopicStaysInsideTheCategory() {
        let category = TopicProvider.categories[3]
        for _ in 0..<50 {
            let topic = TopicProvider.randomTopic(in: category)
            XCTAssertEqual(topic.categoryID, category.id)
        }
    }

    func testRandomTopicWithOnlyOneChoiceReturnsIt() {
        let only = Topic(id: 1, title: "Only one", categoryID: "x")
        let category = TopicCategory(id: "x", title: "X", topics: [only])
        XCTAssertEqual(TopicProvider.randomTopic(in: category, excluding: only), only)
    }

    // MARK: Search

    func testSearchIgnoresCase() {
        let results = TopicProvider.search("nato")
        XCTAssertFalse(results.isEmpty)
        XCTAssertTrue(results.allSatisfy { $0.title.localizedCaseInsensitiveContains("nato") })
    }

    func testSearchMatchesWordStartsOnly() {
        let titles = TopicProvider.search("nato").map(\.title)

        XCTAssertFalse(titles.contains { $0.contains("Pollinator") })
    }

    func testSearchIsLimitedAndEmptyForBlankText() {
        XCTAssertLessThanOrEqual(TopicProvider.search("a").count, 50)
        XCTAssertTrue(TopicProvider.search("   ").isEmpty)
    }

    func testSearchCanBeLimitedToACategory() {
        let category = TopicProvider.categories[0]
        let results = TopicProvider.search("e", in: category)
        XCTAssertTrue(results.allSatisfy { $0.categoryID == category.id })
    }
}
