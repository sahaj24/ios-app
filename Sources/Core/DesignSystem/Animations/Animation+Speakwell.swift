import SwiftUI

/// Shared motion. Views reference these names instead of ad-hoc durations,
/// so the whole app feels consistent and calm.
extension Animation {
    /// Quick feedback, e.g. a button press.
    static let speakwellQuick = Animation.easeInOut(duration: 0.18)

    /// Standard transition, e.g. a crossfade between pieces of text.
    static let speakwellStandard = Animation.easeInOut(duration: 0.3)

    /// Gentle reveal, e.g. a ring filling or a number counting up.
    static let speakwellGentle = Animation.easeOut(duration: 0.9)

    /// Soft spring for a sliding selection (segmented control, tab bar).
    static let speakwellSpring = Animation.spring(response: 0.4, dampingFraction: 0.85)

    /// Slow breathing pulse for the record halo. Repeats until stopped.
    static let speakwellPulse = Animation.easeInOut(duration: 1.6).repeatForever(autoreverses: true)
}
