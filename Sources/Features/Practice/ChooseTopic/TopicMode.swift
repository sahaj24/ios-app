import Foundation

/// The two options of the toggle on "Choose Your Topic".
enum TopicMode: String, SegmentOption {
    case random = "Random topic"
    case own = "My own topic"

    var title: String { rawValue }
}
