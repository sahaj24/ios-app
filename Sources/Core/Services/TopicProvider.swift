import Foundation

/// Debate topics for the Choose Your Topic screen. The raw data lives in
/// `DebateTopics` (20 categories x 100 topics); this turns it into models.
enum TopicProvider {
    /// The 20 categories in the data file's order. Topic ids run 1...2000.
    static let categories: [TopicCategory] = {
        var nextID = 1
        return DebateTopics.masterArray.map { key in
            let titles = DebateTopics.topicsByName[key] ?? []
            let topics = titles.map { title -> Topic in
                defer { nextID += 1 }
                return Topic(id: nextID, title: title, categoryID: key)
            }
            return TopicCategory(id: key, title: DebateTopics.titles[key] ?? key, topics: topics)
        }
    }()

    /// All 2000 topics in one flat list.
    static let allTopics: [Topic] = categories.flatMap(\.topics)

    /// A fixed first topic, used by previews and tests.
    static var defaultTopic: Topic { allTopics[0] }

    static func category(for topic: Topic) -> TopicCategory? {
        categories.first { $0.id == topic.categoryID }
    }

    /// A random topic from `category` (or from everything when nil) that is
    /// different from `current`.
    static func randomTopic(in category: TopicCategory? = nil, excluding current: Topic? = nil) -> Topic {
        let pool = category?.topics ?? allTopics
        let others = pool.filter { $0 != current }
        return others.randomElement() ?? pool.first ?? defaultTopic
    }

    /// Topics with a word that starts with `text` (ignoring case), searched
    /// in `category` or in everything when nil. At most `limit` results.
    /// "nato" finds "NATO expansion" but not "Pollinator".
    static func search(_ text: String, in category: TopicCategory? = nil, limit: Int = 50) -> [Topic] {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return [] }
        let pool = category?.topics ?? allTopics
        let matches = pool.filter { (" " + $0.title.lowercased()).contains(" " + query) }
        return Array(matches.prefix(limit))
    }
}
