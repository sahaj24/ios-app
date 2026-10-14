import Foundation

/// Where the topic on the card came from. It decides the card label and what
/// the shuffle button draws from.
enum TopicSource: Equatable {
    /// Random from all topics.
    case suggested
    /// Random from one category; shuffle keeps drawing from it.
    case category(TopicCategory)
    /// Chosen by hand in the picker.
    case picked

    /// The category shuffle draws from, or nil for all topics.
    var category: TopicCategory? {
        if case .category(let category) = self { return category }
        return nil
    }
}
