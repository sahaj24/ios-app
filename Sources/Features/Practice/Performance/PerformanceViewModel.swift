import Foundation

final class PerformanceViewModel: ObservableObject {
    let skills: [SkillScore]
    let tips: [CoachingTip]
    let reviewTitle = "Review transcript"
    let reviewSubtitle = "Your speech & suggested version"

    init(
        score: SpeechScore = SpeechScoreProvider.latest,
        tips: [CoachingTip] = CoachingTipProvider.tips
    ) {
        skills = score.skills
        self.tips = tips
    }

    /// Progress values for the rings, outer first.
    var ringFractions: [Double] {
        skills.map(\.fraction)
    }
}
