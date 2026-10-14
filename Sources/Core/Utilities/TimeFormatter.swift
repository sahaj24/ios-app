import Foundation

/// Turns a number of seconds into the text shown by the timers.
enum TimeFormatter {
    /// 120 -> "2:00". Negative values are shown as "0:00".
    static func clockText(seconds: Int) -> String {
        let total = max(seconds, 0)
        return String(format: "%d:%02d", total / 60, total % 60)
    }

    /// 120 -> "2 min", 90 -> "1 min 30 sec", 45 -> "45 sec".
    static func durationText(seconds: Int) -> String {
        let (minutes, rest) = split(seconds)
        if minutes == 0 { return "\(rest) sec" }
        if rest == 0 { return "\(minutes) min" }
        return "\(minutes) min \(rest) sec"
    }

    /// 120 -> "2 minutes", 90 -> "1 minute 30 seconds", 45 -> "45 seconds".
    static func longDurationText(seconds: Int) -> String {
        let (minutes, rest) = split(seconds)
        let minuteText = "\(minutes) \(minutes == 1 ? "minute" : "minutes")"
        let secondText = "\(rest) \(rest == 1 ? "second" : "seconds")"
        if minutes == 0 { return secondText }
        if rest == 0 { return minuteText }
        return "\(minuteText) \(secondText)"
    }

    /// Always minutes and padded seconds: 120 -> "2 min 00 sec".
    static func summaryText(seconds: Int) -> String {
        let (minutes, rest) = split(seconds)
        return String(format: "%d min %02d sec", minutes, rest)
    }

    private static func split(_ seconds: Int) -> (minutes: Int, seconds: Int) {
        let total = max(seconds, 0)
        return (total / 60, total % 60)
    }
}
