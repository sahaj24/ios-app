import XCTest
@testable import Speakwell

final class RouletteSpinTests: XCTestCase {
    private let pool = Array(TopicProvider.categories[0].topics.prefix(10))

    func testFramesAndDelaysMatchTheStepCount() {
        let spin = RouletteSpin.make(pool: pool, excluding: pool[0], steps: 12)
        XCTAssertEqual(spin.frames.count, 12)
        XCTAssertEqual(spin.delays.count, 12)
    }

    func testNeverLandsOnTheCurrentTopic() {
        for _ in 0..<100 {
            let spin = RouletteSpin.make(pool: pool, excluding: pool[0])
            XCTAssertNotEqual(spin.frames.last, pool[0])
        }
    }

    func testNeighbouringFramesDiffer() {
        for _ in 0..<50 {
            let frames = RouletteSpin.make(pool: pool, excluding: pool[0]).frames
            for pair in zip(frames, frames.dropFirst()) {
                XCTAssertNotEqual(pair.0, pair.1)
            }
        }
    }

    func testDelaysStartFastAndSlowDown() {
        let delays = RouletteSpin.make(pool: pool, excluding: nil, steps: 10).delays
        XCTAssertEqual(delays.first ?? 0, RouletteSpin.fastestDelay, accuracy: 0.0001)
        XCTAssertEqual(delays.last ?? 0, RouletteSpin.slowestDelay, accuracy: 0.0001)
        XCTAssertEqual(delays, delays.sorted())
    }

    func testEmptyPoolGivesAnEmptySpin() {
        let spin = RouletteSpin.make(pool: [], excluding: nil)
        XCTAssertTrue(spin.frames.isEmpty)
    }

    func testPoolOfTwoStillLandsOnTheOtherTopic() {
        let two = Array(pool.prefix(2))
        let spin = RouletteSpin.make(pool: two, excluding: two[0], steps: 7)
        XCTAssertEqual(spin.frames.last, two[1])
    }
}
