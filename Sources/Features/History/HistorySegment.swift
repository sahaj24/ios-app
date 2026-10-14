import Foundation

/// The two options of the toggle on "History".
enum HistorySegment: String, SegmentOption {
    case sessions = "Sessions"
    case streak = "Streak"

    var title: String { rawValue }
}
