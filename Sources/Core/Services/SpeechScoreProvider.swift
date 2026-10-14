import Foundation

/// Mock score for the finished speech.
enum SpeechScoreProvider {
    static let latest = SpeechScore(
        overall: 88,
        goal: 75,
        skills: [
            SkillScore(name: "Topic relevance", value: 92),
            SkillScore(name: "Fluency", value: 91),
            SkillScore(name: "Vocabulary", value: 87)
        ]
    )
}
