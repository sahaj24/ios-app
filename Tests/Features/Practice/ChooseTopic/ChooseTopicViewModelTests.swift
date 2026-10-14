import XCTest
@testable import Speakwell

final class ChooseTopicViewModelTests: XCTestCase {
    private let start = TopicProvider.defaultTopic

    /// A view model with a fixed first topic and no waiting in the roulette.
    private func makeViewModel() -> ChooseTopicViewModel {
        ChooseTopicViewModel(topic: start, spinSpeed: 0)
    }

    func testDefaults() {
        let viewModel = makeViewModel()
        XCTAssertEqual(viewModel.mode, .random)
        XCTAssertEqual(viewModel.cardLabel, "Suggested topic")
        XCTAssertEqual(viewModel.cardText, start.title)
        XCTAssertEqual(viewModel.source, .suggested)
        XCTAssertFalse(viewModel.isSpinning)
        XCTAssertFalse(viewModel.showsTopicPicker)
        XCTAssertEqual(viewModel.prepOption, .preset(seconds: 120))
        XCTAssertEqual(viewModel.speakOption, .preset(seconds: 120))
        XCTAssertNil(viewModel.customSheet)
        XCTAssertFalse(viewModel.isOwnTopic)
        XCTAssertTrue(viewModel.canStart)
    }

    func testOwnTopicModeIsEditable() {
        let viewModel = makeViewModel()
        viewModel.mode = .own
        XCTAssertTrue(viewModel.isOwnTopic)
        XCTAssertEqual(viewModel.cardLabel, "Your topic")
    }

    func testOwnTopicNeedsTextToStart() {
        let viewModel = makeViewModel()
        viewModel.mode = .own
        XCTAssertFalse(viewModel.canStart)

        viewModel.ownTopic = "   \n "
        XCTAssertFalse(viewModel.canStart)

        viewModel.ownTopic = "  Should homework be banned?  "
        XCTAssertTrue(viewModel.canStart)
    }

    func testSessionUsesTypedTopicOnOwnTab() {
        let viewModel = makeViewModel()
        viewModel.mode = .own
        viewModel.ownTopic = "  Should homework be banned?  "
        XCTAssertEqual(viewModel.makeSession().topic.title, "Should homework be banned?")

        viewModel.mode = .random
        XCTAssertEqual(viewModel.makeSession().topic, start)
    }

    // MARK: Shuffle and roulette

    func testShuffleWithoutAnimationChangesTopicAtOnce() {
        let viewModel = makeViewModel()
        viewModel.shuffleTopic(animated: false)
        XCTAssertNotEqual(viewModel.topic, start)
        XCTAssertFalse(viewModel.isSpinning)
    }

    func testRouletteLandsOnADifferentTopic() async {
        let viewModel = makeViewModel()
        viewModel.shuffleTopic()
        XCTAssertTrue(viewModel.isSpinning)
        await viewModel.spinTask?.value
        XCTAssertFalse(viewModel.isSpinning)
        XCTAssertNotEqual(viewModel.topic, start)
    }

    func testShuffleIsIgnoredWhileSpinning() {
        let viewModel = makeViewModel()
        viewModel.shuffleTopic()
        let firstSpin = viewModel.spinTask
        XCTAssertNotNil(firstSpin)
        viewModel.shuffleTopic()
        XCTAssertEqual(viewModel.spinTask, firstSpin)
        XCTAssertTrue(viewModel.isSpinning)
    }

    // MARK: Category and picker

    func testRandomFromCategoryStaysInTheCategoryAndKeepsShuffleThere() async {
        let viewModel = makeViewModel()
        let category = TopicProvider.categories[11]
        viewModel.randomTopic(in: category)
        await viewModel.spinTask?.value
        XCTAssertEqual(viewModel.topic.categoryID, category.id)
        XCTAssertEqual(viewModel.source, .category(category))
        XCTAssertEqual(viewModel.cardLabel, category.title)

        viewModel.shuffleTopic()
        await viewModel.spinTask?.value
        XCTAssertEqual(viewModel.topic.categoryID, category.id)
    }

    func testRandomFromAllTopicsResetsTheCategory() async {
        let viewModel = makeViewModel()
        viewModel.randomTopic(in: TopicProvider.categories[2])
        await viewModel.spinTask?.value
        viewModel.randomTopic(in: nil)
        await viewModel.spinTask?.value
        XCTAssertEqual(viewModel.source, .suggested)
        XCTAssertEqual(viewModel.cardLabel, "Suggested topic")
    }

    func testRandomFromPickerClosesTheSheet() {
        let viewModel = makeViewModel()
        viewModel.openTopicPicker()
        XCTAssertTrue(viewModel.showsTopicPicker)
        viewModel.randomTopic(in: nil)
        XCTAssertFalse(viewModel.showsTopicPicker)
    }

    func testPickingATopic() {
        let viewModel = makeViewModel()
        let chosen = TopicProvider.allTopics[777]
        viewModel.openTopicPicker()
        viewModel.pick(chosen)
        XCTAssertEqual(viewModel.topic, chosen)
        XCTAssertEqual(viewModel.source, .picked)
        XCTAssertEqual(viewModel.cardLabel, "Picked topic")
        XCTAssertFalse(viewModel.showsTopicPicker)
    }

    func testPickingWhileSpinningCancelsTheRoulette() async {
        let viewModel = makeViewModel()
        viewModel.shuffleTopic()
        let chosen = TopicProvider.allTopics[10]
        viewModel.pick(chosen)
        await viewModel.spinTask?.value
        XCTAssertFalse(viewModel.isSpinning)
        XCTAssertEqual(viewModel.topic, chosen)
    }

    func testShuffleAfterPickingDrawsFromAllTopics() {
        let viewModel = makeViewModel()
        viewModel.pick(TopicProvider.allTopics[500])
        viewModel.shuffleTopic(animated: false)
        XCTAssertEqual(viewModel.source, .suggested)
        XCTAssertEqual(viewModel.cardLabel, "Suggested topic")
    }

    // MARK: Times

    func testSelectPreset() {
        let viewModel = makeViewModel()
        viewModel.select(.preset(seconds: 300), for: .preparation)
        viewModel.select(.preset(seconds: 60), for: .speaking)
        XCTAssertEqual(viewModel.option(for: .preparation), .preset(seconds: 300))
        XCTAssertEqual(viewModel.option(for: .speaking), .preset(seconds: 60))
        XCTAssertEqual(viewModel.label(for: .preparation), "5 min")
        XCTAssertEqual(viewModel.label(for: .speaking), "1 min")
    }

    func testBeginCustomOpensSheet() {
        let viewModel = makeViewModel()
        viewModel.beginCustom(for: .speaking)
        XCTAssertEqual(viewModel.customSheet, .speaking)
    }

    func testApplyCustomSetsOptionAndClosesSheet() {
        let viewModel = makeViewModel()
        viewModel.beginCustom(for: .speaking)
        viewModel.applyCustom(seconds: 90, for: .speaking)
        XCTAssertEqual(viewModel.speakOption, .custom(seconds: 90))
        XCTAssertEqual(viewModel.label(for: .speaking), "1 min 30 sec")
        XCTAssertNil(viewModel.customSheet)
        XCTAssertEqual(viewModel.prepOption, .preset(seconds: 120))
    }

    func testApplyCustomClampsPreparation() {
        let viewModel = makeViewModel()
        viewModel.applyCustom(seconds: 45, for: .preparation)
        XCTAssertEqual(viewModel.prepOption.seconds, 120)
        viewModel.applyCustom(seconds: 700, for: .preparation)
        XCTAssertEqual(viewModel.prepOption.seconds, 600)
    }

    func testApplyCustomClampsSpeaking() {
        let viewModel = makeViewModel()
        viewModel.applyCustom(seconds: 0, for: .speaking)
        XCTAssertEqual(viewModel.speakOption.seconds, 30)
        viewModel.applyCustom(seconds: 1000, for: .speaking)
        XCTAssertEqual(viewModel.speakOption.seconds, 900)
    }

    func testMakeSessionCarriesSeconds() {
        let viewModel = makeViewModel()
        viewModel.select(.preset(seconds: 180), for: .preparation)
        viewModel.applyCustom(seconds: 90, for: .speaking)

        let session = viewModel.makeSession()
        XCTAssertEqual(session.topic, viewModel.topic)
        XCTAssertEqual(session.prepSeconds, 180)
        XCTAssertEqual(session.speakSeconds, 90)
    }
}
