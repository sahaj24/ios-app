import Foundation

/// Mock "How to get better" tips.
enum CoachingTipProvider {
    static let tips: [CoachingTip] = [
        CoachingTip(id: 1, title: "Filler words", detail: "7 filler words in this speech"),
        CoachingTip(id: 2, title: "Clearer wording", detail: "3 wording suggestions"),
        CoachingTip(id: 3, title: "Speech structure", detail: "Opening, key points and closing")
    ]
}
