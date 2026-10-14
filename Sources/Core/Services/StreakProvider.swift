import Foundation

/// Mock streak data that matches the Figma design. Replace with real session
/// history later.
enum StreakProvider {
    /// Page shown first: "28 September–4 October", as in the design mock.
    static let initialWeekIndex = 2

    static let current = StreakSummary(
        currentStreak: 5,
        longestStreak: 8,
        daysThisMonth: 8,
        weeks: [
            week("14–20 September",
                 numbers: [14, 15, 16, 17, 18, 19, 20],
                 practiced: [false, true, true, false, true, false, true]),
            week("21–27 September",
                 numbers: [21, 22, 23, 24, 25, 26, 27],
                 practiced: [true, true, true, true, false, true, true]),
            week("28 September–4 October",
                 numbers: [28, 29, 30, 1, 2, 3, 4],
                 practiced: [true, true, true, true, true, true, false]),
            week("5–11 October",
                 numbers: [5, 6, 7, 8, 9, 10, 11],
                 practiced: [true, true, true, true, true, false, false])
        ]
    )

    private static let weekdays = ["M", "T", "W", "T", "F", "S", "S"]

    private static func week(_ title: String, numbers: [Int], practiced: [Bool]) -> StreakWeek {
        let days = numbers.indices.map {
            StreakDay(weekday: weekdays[$0], number: numbers[$0], isPracticed: practiced[$0])
        }
        return StreakWeek(title: title, days: days)
    }
}
