import SwiftUI

/// A whole number that counts up from zero to `target` when it appears.
/// Uses the surrounding `.font`. Respects Reduce Motion (shows the final
/// value immediately).
struct CountUpNumber: View {
    let target: Int

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var current: Double = 0

    var body: some View {
        AnimatableNumberText(value: current)
            .onAppear {
                if reduceMotion {
                    current = Double(target)
                } else {
                    withAnimation(.speakwellGentle) { current = Double(target) }
                }
            }
    }
}

/// Text whose number interpolates while `value` animates.
private struct AnimatableNumberText: View, Animatable {
    var value: Double

    var animatableData: Double {
        get { value }
        set { value = newValue }
    }

    var body: some View {
        Text("\(Int(value.rounded()))")
    }
}

#Preview {
    CountUpNumber(target: 88)
        .font(.swScoreDisplay)
        .foregroundColor(.swText)
        .screenBackground()
}
