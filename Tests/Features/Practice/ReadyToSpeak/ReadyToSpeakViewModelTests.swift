import XCTest
@testable import Speakwell

final class ReadyToSpeakViewModelTests: XCTestCase {
    private var finishCount = 0

    private func makeViewModel(speakSeconds: Int = 120) -> ReadyToSpeakViewModel {
        finishCount = 0
        let session = PracticeSession(topic: TopicProvider.defaultTopic, prepSeconds: 120, speakSeconds: speakSeconds)
        return ReadyToSpeakViewModel(session: session) { [weak self] in self?.finishCount += 1 }
    }

    func testInitialState() {
        let viewModel = makeViewModel()
        XCTAssertEqual(viewModel.timerText, "0:00")
        XCTAssertEqual(viewModel.titleText, "Tap to start speaking")
        XCTAssertEqual(viewModel.limitText, "2 minutes to speak")
        XCTAssertFalse(viewModel.isRecording)
    }

    func testSingularMinute() {
        XCTAssertEqual(makeViewModel(speakSeconds: 60).limitText, "1 minute to speak")
    }

    func testCustomSecondsInLimitText() {
        XCTAssertEqual(makeViewModel(speakSeconds: 90).limitText, "1 minute 30 seconds to speak")
    }

    func testDoesNotFinishBeforeTimeIsUp() {
        let viewModel = makeViewModel(speakSeconds: 90)
        viewModel.toggleRecording()
        for _ in 0..<89 { viewModel.tick() }
        XCTAssertEqual(finishCount, 0)
        XCTAssertTrue(viewModel.isRecording)
    }

    func testTickDoesNothingBeforeRecording() {
        let viewModel = makeViewModel()
        viewModel.tick()
        XCTAssertEqual(viewModel.elapsedSeconds, 0)
    }

    func testTickCountsWhileRecording() {
        let viewModel = makeViewModel()
        viewModel.toggleRecording()
        viewModel.tick()
        viewModel.tick()
        XCTAssertEqual(viewModel.timerText, "0:02")
        XCTAssertEqual(viewModel.titleText, "Tap to stop speaking")
    }

    func testSecondTapFinishes() {
        let viewModel = makeViewModel()
        viewModel.toggleRecording()
        viewModel.toggleRecording()
        XCTAssertFalse(viewModel.isRecording)
        XCTAssertEqual(finishCount, 1)
    }

    func testFinishesWhenTimeIsUp() {
        let viewModel = makeViewModel(speakSeconds: 90)
        viewModel.toggleRecording()
        for _ in 0..<90 { viewModel.tick() }
        XCTAssertEqual(finishCount, 1)
        XCTAssertFalse(viewModel.isRecording)
    }
}
