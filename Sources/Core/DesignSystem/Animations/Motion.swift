import SwiftUI

/// One place for Reduce Motion decisions, so views don't repeat the check.
enum Motion {
    /// Returns `animation`, or `nil` (no animation) when Reduce Motion is on.
    /// Pass the result straight to `withAnimation(_:)` or `.animation(_:value:)`.
    static func gated(_ animation: Animation, reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : animation
    }
}
