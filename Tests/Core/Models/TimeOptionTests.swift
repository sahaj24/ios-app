import XCTest
@testable import Speakwell

final class TimeOptionTests: XCTestCase {
    func testSecondsAndIsCustom() {
        XCTAssertEqual(TimeOption.preset(seconds: 180).seconds, 180)
        XCTAssertFalse(TimeOption.preset(seconds: 180).isCustom)
        XCTAssertEqual(TimeOption.custom(seconds: 90).seconds, 90)
        XCTAssertTrue(TimeOption.custom(seconds: 90).isCustom)
    }

    func testLabels() {
        XCTAssertEqual(TimeOption.preset(seconds: 120).label, "2 min")
        XCTAssertEqual(TimeOption.custom(seconds: 90).label, "1 min 30 sec")
        XCTAssertEqual(TimeOption.custom(seconds: 45).label, "45 sec")
        XCTAssertEqual(TimeOption.preset(seconds: 600).label, "10 min")
        XCTAssertEqual(TimeOption.preset(seconds: 60).longLabel, "1 minute")
        XCTAssertEqual(TimeOption.preset(seconds: 300).longLabel, "5 minutes")
    }

    func testPreparationClamping() {
        let range = TimeKind.preparation.range
        XCTAssertEqual(range, 120...600)
        XCTAssertEqual(TimeOption.custom(seconds: 119, in: range).seconds, 120)
        XCTAssertEqual(TimeOption.custom(seconds: 0, in: range).seconds, 120)
        XCTAssertEqual(TimeOption.custom(seconds: 120, in: range).seconds, 120)
        XCTAssertEqual(TimeOption.custom(seconds: 330, in: range).seconds, 330)
        XCTAssertEqual(TimeOption.custom(seconds: 600, in: range).seconds, 600)
        XCTAssertEqual(TimeOption.custom(seconds: 601, in: range).seconds, 600)
    }

    func testSpeakingClamping() {
        let range = TimeKind.speaking.range
        XCTAssertEqual(range, 30...900)
        XCTAssertEqual(TimeOption.custom(seconds: 0, in: range).seconds, 30)
        XCTAssertEqual(TimeOption.custom(seconds: 29, in: range).seconds, 30)
        XCTAssertEqual(TimeOption.custom(seconds: 30, in: range).seconds, 30)
        XCTAssertEqual(TimeOption.custom(seconds: 450, in: range).seconds, 450)
        XCTAssertEqual(TimeOption.custom(seconds: 900, in: range).seconds, 900)
        XCTAssertEqual(TimeOption.custom(seconds: 901, in: range).seconds, 900)
    }

    func testClampedOptionIsCustom() {
        XCTAssertTrue(TimeOption.custom(seconds: 5, in: TimeKind.speaking.range).isCustom)
    }

    func testKindPresetsAndWheels() {
        XCTAssertEqual(TimeKind.preparation.presets, [120, 180, 300, 600])
        XCTAssertEqual(TimeKind.speaking.presets, [60, 120, 180, 300])
        XCTAssertEqual(TimeKind.preparation.minuteValues, Array(2...10))
        XCTAssertEqual(TimeKind.speaking.minuteValues, Array(0...15))
    }
}
