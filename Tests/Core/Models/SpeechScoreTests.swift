import XCTest
@testable import Speakwell

final class SpeechScoreTests: XCTestCase {
    private let score = SpeechScoreProvider.latest

    func testStrongestSkillIsTopicRelevance() {
        XCTAssertEqual(score.strongestSkill?.name, "Topic relevance")
        XCTAssertEqual(score.strongestSkill?.value, 92)
    }

    func testGoalReached() {
        XCTAssertEqual(score.overall, 88)
        XCTAssertTrue(score.isGoalReached)
    }

    func testGoalNotReached() {
        let low = SpeechScore(overall: 50, goal: 75, skills: [])
        XCTAssertFalse(low.isGoalReached)
        XCTAssertNil(low.strongestSkill)
    }

    func testSkillFraction() {
        XCTAssertEqual(SkillScore(name: "Fluency", value: 91).fraction, 0.91, accuracy: 0.0001)
    }
}
