import Foundation

/// One row of the History list.
struct SessionSummary: Identifiable, Equatable {
    let id: Int
    let topicTitle: String
    let dayLabel: String
    let minutes: Int

    /// "Today · 2 min"
    var caption: String { "\(dayLabel) · \(minutes) min" }
}
