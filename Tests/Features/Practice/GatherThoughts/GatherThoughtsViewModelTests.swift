import XCTest
@testable import Speakwell

final class GatherThoughtsViewModelTests: XCTestCase {
    private func makeViewModel(prepSeconds: Int = 120) -> GatherThoughtsViewModel {
        let session = PracticeSession(topic: TopicProvider.defaultTopic, prepSeconds: prepSeconds, speakSeconds: 120)
        return GatherThoughtsViewModel(session: session)
    }

    func testInitialState() {
        let viewModel = makeViewModel()
        XCTAssertEqual(viewModel.remainingText, "2:00")
        XCTAssertEqual(viewModel.progress, 1, accuracy: 0.0001)
        XCTAssertFalse(viewModel.keyPoints.isEmpty)
        XCTAssertNil(viewModel.editingSection)
    }

    func testTickCountsDown() {
        let viewModel = makeViewModel()
        viewModel.tick()
        XCTAssertEqual(viewModel.remainingText, "1:59")
    }

    func testTickStopsAtZero() {
        let viewModel = makeViewModel(prepSeconds: 60)
        for _ in 0..<70 { viewModel.tick() }
        XCTAssertEqual(viewModel.remainingText, "0:00")
        XCTAssertEqual(viewModel.progress, 0, accuracy: 0.0001)
    }

    func testEditLoadsDraft() {
        let viewModel = makeViewModel()
        viewModel.edit(.closing)
        XCTAssertEqual(viewModel.editingSection, .closing)
        XCTAssertEqual(viewModel.draft, viewModel.closing)
    }

    func testSaveWritesTrimmedDraftAndClosesSheet() {
        let viewModel = makeViewModel()
        viewModel.edit(.opening)
        viewModel.draft = "  A fresh opening.  "
        viewModel.save()
        XCTAssertEqual(viewModel.opening, "A fresh opening.")
        XCTAssertNil(viewModel.editingSection)
    }

    func testSaveReportsTheWholeOutline() {
        var reported: Outline?
        let session = PracticeSession(topic: TopicProvider.defaultTopic, prepSeconds: 120, speakSeconds: 120)
        let viewModel = GatherThoughtsViewModel(session: session) { reported = $0 }

        viewModel.edit(.closing)
        viewModel.draft = "Be kind."
        viewModel.save()

        XCTAssertEqual(reported?.closing, "Be kind.")
        XCTAssertEqual(reported?.opening, viewModel.opening)
    }

    func testStartsFromTheGivenOutline() {
        let session = PracticeSession(topic: TopicProvider.defaultTopic, prepSeconds: 120, speakSeconds: 120)
        let outline = Outline(opening: "A", keyPoints: "B", closing: "C")

        let viewModel = GatherThoughtsViewModel(session: session, outline: outline)

        XCTAssertEqual(viewModel.outline, outline)
    }

    func testCancelLeavesTextUnchanged() {
        let viewModel = makeViewModel()
        let original = viewModel.keyPoints
        viewModel.edit(.keyPoints)
        viewModel.draft = "changed"
        viewModel.cancelEdit()
        XCTAssertEqual(viewModel.keyPoints, original)
        XCTAssertNil(viewModel.editingSection)
    }
}
