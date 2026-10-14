import Foundation

/// One "How to get better" row on the Performance screen.
struct CoachingTip: Identifiable, Equatable {
    let id: Int
    let title: String
    let detail: String
}
