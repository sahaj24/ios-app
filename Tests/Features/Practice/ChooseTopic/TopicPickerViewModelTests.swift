import XCTest
@testable import Speakwell

final class TopicPickerViewModelTests: XCTestCase {
    func testStartsOnTheCategoryList() {
        let viewModel = TopicPickerViewModel()
        XCTAssertEqual(viewModel.title, "Pick a topic")
        XCTAssertEqual(viewModel.categories.count, 20)
        XCTAssertNil(viewModel.selectedCategory)
        XCTAssertFalse(viewModel.isSearching)
        XCTAssertEqual(viewModel.randomButtonTitle, "Random from all topics")
    }

    func testOpeningACategory() {
        let viewModel = TopicPickerViewModel()
        let category = viewModel.categories[1]
        viewModel.open(category)
        XCTAssertEqual(viewModel.selectedCategory, category)
        XCTAssertEqual(viewModel.title, category.title)
        XCTAssertEqual(viewModel.categoryTopics.count, 100)
        XCTAssertEqual(viewModel.randomButtonTitle, "Random from this category")
        XCTAssertEqual(viewModel.countText(for: category), "100 topics")
    }

    func testBackReturnsToCategoriesAndClearsSearch() {
        let viewModel = TopicPickerViewModel()
        viewModel.open(viewModel.categories[0])
        viewModel.searchText = "nato"
        viewModel.back()
        XCTAssertNil(viewModel.selectedCategory)
        XCTAssertEqual(viewModel.searchText, "")
    }

    func testSearchScopeFollowsTheOpenCategory() {
        let viewModel = TopicPickerViewModel()
        viewModel.searchText = "the"
        XCTAssertTrue(viewModel.isSearching)
        XCTAssertGreaterThan(Set(viewModel.searchResults.map(\.categoryID)).count, 1)

        let category = viewModel.categories[4]
        viewModel.open(category)
        viewModel.searchText = "the"
        XCTAssertTrue(viewModel.searchResults.allSatisfy { $0.categoryID == category.id })
        XCTAssertEqual(viewModel.searchPlaceholder, "Search this category")
    }

    func testOpeningACategoryClearsOldSearch() {
        let viewModel = TopicPickerViewModel()
        viewModel.searchText = "nato"
        viewModel.open(viewModel.categories[0])
        XCTAssertEqual(viewModel.searchText, "")
    }
}
