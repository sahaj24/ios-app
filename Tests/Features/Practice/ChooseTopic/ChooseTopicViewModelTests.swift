import XCTest
@testable import Speakwell

final class ChooseTopicViewModelTests: XCTestCase {
    func testDefaults() {
        let viewModel = ChooseTopicViewModel()
        XCTAssertEqual(viewModel.mode, .random)
        XCTAssertEqual(viewModel.cardLabel, "Suggested topic")
        XCTAssertEqual(viewModel.cardText, "Is social media bringing us closer?")
        XCTAssertEqual(viewModel.prepOption, .preset(seconds: 120))
        XCTAssertEqual(viewModel.speakOption, .preset(seconds: 120))
        XCTAssertNil(viewModel.customSheet)
        XCTAssertTrue(viewModel.showsShuffle)
    }

    func testShuffleChangesTopic() {
        let viewModel = ChooseTopicViewModel()
        let before = viewModel.topic
        viewModel.shuffleTopic()
        XCTAssertNotEqual(viewModel.topic, before)
    }

    func testOwnTopicModeHidesShuffle() {
        let viewModel = ChooseTopicViewModel()
        viewModel.mode = .own
        XCTAssertFalse(viewModel.showsShuffle)
        XCTAssertEqual(viewModel.cardLabel, "Your topic")
    }

    func testSelectPreset() {
        let viewModel = ChooseTopicViewModel()
        viewModel.select(.preset(seconds: 300), for: .preparation)
        viewModel.select(.preset(seconds: 60), for: .speaking)
        XCTAssertEqual(viewModel.option(for: .preparation), .preset(seconds: 300))
        XCTAssertEqual(viewModel.option(for: .speaking), .preset(seconds: 60))
        XCTAssertEqual(viewModel.label(for: .preparation), "5 min")
        XCTAssertEqual(viewModel.label(for: .speaking), "1 min")
    }

    func testBeginCustomOpensSheet() {
        let viewModel = ChooseTopicViewModel()
        viewModel.beginCustom(for: .speaking)
        XCTAssertEqual(viewModel.customSheet, .speaking)
    }

    func testApplyCustomSetsOptionAndClosesSheet() {
        let viewModel = ChooseTopicViewModel()
        viewModel.beginCustom(for: .speaking)
        viewModel.applyCustom(seconds: 90, for: .speaking)
        XCTAssertEqual(viewModel.speakOption, .custom(seconds: 90))
        XCTAssertEqual(viewModel.label(for: .speaking), "1 min 30 sec")
        XCTAssertNil(viewModel.customSheet)
        XCTAssertEqual(viewModel.prepOption, .preset(seconds: 120))
    }

    func testApplyCustomClampsPreparation() {
        let viewModel = ChooseTopicViewModel()
        viewModel.applyCustom(seconds: 45, for: .preparation)
        XCTAssertEqual(viewModel.prepOption.seconds, 120)
        viewModel.applyCustom(seconds: 700, for: .preparation)
        XCTAssertEqual(viewModel.prepOption.seconds, 600)
    }

    func testApplyCustomClampsSpeaking() {
        let viewModel = ChooseTopicViewModel()
        viewModel.applyCustom(seconds: 0, for: .speaking)
        XCTAssertEqual(viewModel.speakOption.seconds, 30)
        viewModel.applyCustom(seconds: 1000, for: .speaking)
        XCTAssertEqual(viewModel.speakOption.seconds, 900)
    }

    func testMakeSessionCarriesSeconds() {
        let viewModel = ChooseTopicViewModel()
        viewModel.select(.preset(seconds: 180), for: .preparation)
        viewModel.applyCustom(seconds: 90, for: .speaking)

        let session = viewModel.makeSession()
        XCTAssertEqual(session.topic, viewModel.topic)
        XCTAssertEqual(session.prepSeconds, 180)
        XCTAssertEqual(session.speakSeconds, 90)
    }
}
