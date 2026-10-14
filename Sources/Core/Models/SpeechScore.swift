import Foundation

/// The result of one speech: an overall score plus three skill scores.
struct SpeechScore: Equatable {
    let overall: Int
    let goal: Int
    let skills: [SkillScore]

    var isGoalReached: Bool { overall >= goal }

    var strongestSkill: SkillScore? {
        skills.max { $0.value < $1.value }
    }
}
