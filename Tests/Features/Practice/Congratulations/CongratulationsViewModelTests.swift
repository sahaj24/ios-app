import XCTest
@testable import Speakwell

final class CongratulationsViewModelTests: XCTestCase {
    private let viewModel = CongratulationsViewModel()

    func testTexts() {
        XCTAssertEqual(viewModel.headline, "You found your flow.")
        XCTAssertEqual(viewModel.badgeText, "Goal reached")
        XCTAssertEqual(viewModel.overall, 88)
        XCTAssertEqual(viewModel.scoreCaption, "Overall score · out of 100")
    }

    func testStrongestSkillText() {
        XCTAssertEqual(
            viewModel.strongestSkillText,
            "Topic relevance: 92. Your ideas stayed close to the subject."
        )
    }

    func testBadgeWhenGoalMissed() {
        let low = CongratulationsViewModel(score: SpeechScore(overall: 10, goal: 75, skills: []))
        XCTAssertEqual(low.badgeText, "Nice effort")
        XCTAssertEqual(low.strongestSkillText, "")
    }
}
