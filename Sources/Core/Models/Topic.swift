import Foundation

struct Topic: Identifiable, Equatable {
    let id: Int
    let title: String
    /// Which `TopicCategory` this topic belongs to (its `id`).
    let categoryID: String
}
