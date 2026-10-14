import Foundation

final class CongratulationsViewModel: ObservableObject {
    let score: SpeechScore

    init(score: SpeechScore = SpeechScoreProvider.latest) {
        self.score = score
    }

    let headline = "You found your flow."
    let scoreCaption = "Overall score · out of 100"

    var badgeText: String {
        score.isGoalReached ? "Goal reached" : "Nice effort"
    }

    var overall: Int {
        score.overall
    }

    /// "Topic relevance: 92. Your ideas stayed close to the subject."
    var strongestSkillText: String {
        guard let skill = score.strongestSkill else { return "" }
        return "\(skill.name): \(skill.value). Your ideas stayed close to the subject."
    }
}
