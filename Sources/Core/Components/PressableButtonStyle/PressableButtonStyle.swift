import SwiftUI

/// Button style that gently scales down while pressed. It adds no other
/// styling, so it is a drop-in replacement for `.plain`.
struct PressableButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.97 : 1)
            .animation(.speakwellQuick, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PressableButtonStyle {
    /// `.buttonStyle(.speakwellPressable)` — plain look with a soft press scale.
    static var speakwellPressable: PressableButtonStyle { PressableButtonStyle() }
}
