import Foundation

/// The plan for one roulette spin: a list of topics to flash on the card and
/// how long to wait before showing each one. The waits grow, so the roulette
/// starts fast and slows down until it lands on the last topic.
struct RouletteSpin: Equatable {
    /// Topics shown in order. The last one is where the roulette lands.
    let frames: [Topic]
    /// Seconds to wait before showing `frames[i]`.
    let delays: [TimeInterval]

    static let defaultSteps = 14
    static let fastestDelay: TimeInterval = 0.05
    static let slowestDelay: TimeInterval = 0.30

    /// A spin over `pool`. No two neighbouring frames are the same, and the
    /// landing topic is never `current`.
    static func make(pool: [Topic], excluding current: Topic?, steps: Int = defaultSteps) -> RouletteSpin {
        guard !pool.isEmpty, steps > 0 else { return RouletteSpin(frames: [], delays: []) }

        var frames: [Topic] = []
        var previous = current
        for step in 0..<steps {
            let isLanding = step == steps - 1
            let options = pool.filter { topic in
                topic != previous && !(isLanding && topic == current)
            }
            let next = options.randomElement() ?? pool[0]
            frames.append(next)
            previous = next
        }
        let delays = (0..<steps).map { delay(at: $0, of: steps) }
        return RouletteSpin(frames: frames, delays: delays)
    }

    /// Quadratic ease-out: quick at first, then slower and slower.
    static func delay(at index: Int, of count: Int) -> TimeInterval {
        guard count > 1 else { return slowestDelay }
        let progress = Double(index) / Double(count - 1)
        return fastestDelay + (slowestDelay - fastestDelay) * progress * progress
    }
}
