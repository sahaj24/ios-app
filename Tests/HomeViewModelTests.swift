import XCTest
@testable import MyApp

final class HomeViewModelTests: XCTestCase {
    func testDefaultTitle() {
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.title, "MyApp")
    }
}
