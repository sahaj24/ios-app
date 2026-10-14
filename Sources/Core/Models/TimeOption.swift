import Foundation

/// A time choice for the preparation or speaking chip: one of the menu presets or a custom value.
enum TimeOption: Equatable {
    case preset(seconds: Int)
    case custom(seconds: Int)

    var seconds: Int {
        switch self {
        case .preset(let seconds), .custom(let seconds):
            return seconds
        }
    }

    var isCustom: Bool {
        if case .custom = self { return true }
        return false
    }

    /// Short text for the chip: "2 min", "1 min 30 sec".
    var label: String {
        TimeFormatter.durationText(seconds: seconds)
    }

    /// Long text for the menu rows: "2 minutes", "1 minute 30 seconds".
    var longLabel: String {
        TimeFormatter.longDurationText(seconds: seconds)
    }

    /// A custom option whose seconds are pulled inside `range`.
    static func custom(seconds: Int, in range: ClosedRange<Int>) -> TimeOption {
        .custom(seconds: min(max(seconds, range.lowerBound), range.upperBound))
    }
}
