import Foundation

/// Everything the History "Streak" segment shows.
struct StreakSummary: Equatable {
    let currentStreak: Int
    let longestStreak: Int
    let daysThisMonth: Int
    /// Oldest week first.
    let weeks: [StreakWeek]

    // MARK: Top stats

    /// "5 days"
    var currentText: String { Self.daysText(currentStreak) }

    /// "8 days"
    var longestText: String { Self.daysText(longestStreak) }

    // MARK: Totals

    /// "8 days"
    var thisMonthText: String { Self.daysText(daysThisMonth) }

    /// "21 days" (every practised day across the weeks shown)
    var lastFourWeeksText: String {
        Self.daysText(weeks.reduce(0) { $0 + $1.practicedCount })
    }

    // MARK: Next milestone (a new personal record)

    /// One day longer than the best streak so far.
    var milestoneDays: Int {
        max(longestStreak, currentStreak) + 1
    }

    /// "9-day streak"
    var milestoneTitle: String {
        "\(milestoneDays)-day streak"
    }

    /// "4 more days to beat your longest streak."
    var milestoneDetail: String {
        let remaining = milestoneDays - currentStreak
        return "\(remaining) more \(remaining == 1 ? "day" : "days") to beat your longest streak."
    }

    private static func daysText(_ count: Int) -> String {
        "\(count) \(count == 1 ? "day" : "days")"
    }
}
