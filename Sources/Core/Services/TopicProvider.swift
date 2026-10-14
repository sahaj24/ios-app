import Foundation

/// Mock topics. Replace with a real source later.
enum TopicProvider {
    static let topics: [Topic] = [
        Topic(id: 1, title: "Is social media bringing us closer?"),
        Topic(id: 2, title: "Why curiosity matters"),
        Topic(id: 3, title: "Should homework be optional?"),
        Topic(id: 4, title: "Can technology make us happier?"),
        Topic(id: 5, title: "The value of learning a new skill"),
        Topic(id: 6, title: "Is competition good for us?")
    ]

    static var defaultTopic: Topic { topics[0] }

    /// A random topic that is different from `current`.
    static func randomTopic(excluding current: Topic) -> Topic {
        let others = topics.filter { $0 != current }
        return others.randomElement() ?? current
    }
}
