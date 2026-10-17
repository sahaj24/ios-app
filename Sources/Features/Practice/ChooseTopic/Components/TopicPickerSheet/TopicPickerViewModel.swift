import Foundation

/// State for the topic picker sheet: the category list, one open category,
/// and the search box.
final class TopicPickerViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var selectedCategory: TopicCategory?

    let categories: [TopicCategory]

    init(categories: [TopicCategory] = TopicProvider.categories) {
        self.categories = categories
    }

    // MARK: What the sheet shows

    var title: String {
        selectedCategory?.title ?? "Pick a topic"
    }

    var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var searchPlaceholder: String {
        selectedCategory == nil ? "Search all topics" : "Search this category"
    }

    /// Matches for the search box, within the open category or everywhere.
    var searchResults: [Topic] {
        TopicProvider.search(searchText, in: selectedCategory)
    }

    /// Topics of the open category (empty when no category is open).
    var categoryTopics: [Topic] {
        selectedCategory?.topics ?? []
    }

    var randomButtonTitle: String {
        selectedCategory == nil ? "Random from all topics" : "Random from this category"
    }

    /// "100 topics"
    func countText(for category: TopicCategory) -> String {
        "\(category.topics.count) topics"
    }

    // MARK: Actions

    func open(_ category: TopicCategory) {
        selectedCategory = category
        searchText = ""
    }

    /// Filter chip tapped: a category, or nil for "All".
    func select(_ category: TopicCategory?) {
        guard let category else { return back() }
        open(category)
    }

    func back() {
        selectedCategory = nil
        searchText = ""
    }
}
