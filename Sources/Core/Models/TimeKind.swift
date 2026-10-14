import Foundation

/// Which of the two session times a chip or sheet is about.
enum TimeKind: String, Identifiable {
    case preparation
    case speaking

    var id: String { rawValue }

    var title: String {
        switch self {
        case .preparation: return "Preparation time"
        case .speaking: return "Speaking time"
        }
    }

    var symbol: String {
        switch self {
        case .preparation: return "timer"
        case .speaking: return "mic"
        }
    }

    /// Sentence under the sheet title.
    var subtitle: String {
        switch self {
        case .preparation: return "Choose how long to gather your thoughts."
        case .speaking: return "Choose how long you want to speak."
        }
    }

    /// Small note at the bottom of the sheet.
    var caption: String {
        switch self {
        case .preparation: return "Minimum preparation time is 2 minutes."
        case .speaking: return "Choose minutes and seconds."
        }
    }

    /// Allowed seconds. Custom values are clamped into this range.
    var range: ClosedRange<Int> {
        switch self {
        case .preparation: return Constants.Session.prepRange
        case .speaking: return Constants.Session.speakRange
        }
    }

    /// Seconds of the menu presets, shortest first.
    var presets: [Int] {
        switch self {
        case .preparation: return Constants.Session.prepPresets
        case .speaking: return Constants.Session.speakPresets
        }
    }

    /// Whole minutes shown on the sheet's minutes wheel.
    var minuteValues: [Int] {
        Array((range.lowerBound / Constants.Session.secondsPerMinute)...(range.upperBound / Constants.Session.secondsPerMinute))
    }
}
