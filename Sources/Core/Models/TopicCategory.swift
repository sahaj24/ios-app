import Foundation

/// A named group of debate topics, e.g. "Ethics and Moral Dilemmas".
struct TopicCategory: Identifiable, Equatable {
    /// Short key from the data file, e.g. "ethics".
    let id: String
    /// Display title, e.g. "Ethics and Moral Dilemmas".
    let title: String
    let topics: [Topic]
}
