import Foundation

/// One day in a streak week: the weekday letter, the date number and whether
/// the user practised that day.
struct StreakDay: Equatable, Identifiable {
    let weekday: String   // "M"
    let number: Int       // 28
    let isPracticed: Bool

    /// Date numbers are unique inside one week, so they work as the id.
    var id: Int { number }
}
