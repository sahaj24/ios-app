import XCTest
@testable import Speakwell

final class DisplayAccessibilityViewModelTests: XCTestCase {
    func testDefaultLabel() {
        let viewModel = DisplayAccessibilityViewModel()
        XCTAssertEqual(viewModel.textSizeLabel, "Default")
    }

    func testLabelAtEachStep() {
        let viewModel = DisplayAccessibilityViewModel()
        let expected = ["Small", "Medium", "Default", "Large", "Extra Large"]
        for (step, label) in expected.enumerated() {
            viewModel.textSize = Double(step)
            XCTAssertEqual(viewModel.textSizeLabel, label)
        }
    }
}
