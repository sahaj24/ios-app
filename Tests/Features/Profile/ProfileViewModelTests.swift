import XCTest
@testable import Speakwell

final class ProfileViewModelTests: XCTestCase {
    func testStats() {
        let viewModel = ProfileViewModel()
        XCTAssertEqual(viewModel.name, "Abhinav")
        XCTAssertEqual(viewModel.sessionCountText, "23")
        XCTAssertEqual(viewModel.averageScoreText, "82")
    }

    func testToggleDefaults() {
        let viewModel = ProfileViewModel()
        XCTAssertTrue(viewModel.showsLiveTranscript)
        XCTAssertFalse(viewModel.dailyReminder)
        XCTAssertTrue(viewModel.hapticFeedback)
    }
}
