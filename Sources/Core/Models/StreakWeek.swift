import Foundation

/// Seven consecutive days, shown as one page of the streak pager.
struct StreakWeek: Equatable, Identifiable {
    let title: String        // "28 September–4 October"
    let days: [StreakDay]

    var id: String { title }

    var practicedCount: Int {
        days.filter(\.isPracticed).count
    }

    /// "6/7 days"
    var countText: String {
        "\(practicedCount)/\(days.count) days"
    }
}
