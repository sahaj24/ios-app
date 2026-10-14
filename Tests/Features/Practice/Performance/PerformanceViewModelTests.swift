import XCTest
@testable import Speakwell

final class PerformanceViewModelTests: XCTestCase {
    private let viewModel = PerformanceViewModel()

    func testRingFractionsAreOuterFirst() {
        XCTAssertEqual(viewModel.ringFractions, [0.92, 0.91, 0.87])
    }

    func testTips() {
        XCTAssertEqual(viewModel.tips.count, 3)
        XCTAssertEqual(viewModel.tips.first?.title, "Filler words")
    }
}
