import SwiftUI

/// Concentric rings (first value = outer ring) with a waveform icon in the middle.
/// Values are 0...1. The rings fill from empty when the view appears.
struct ScoreRings: View {
    let fractions: [Double]

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var shown = false

    private var step: CGFloat { (Constants.Size.ringLine + Constants.Size.ringGap) * 2 }
    private var outerDiameter: CGFloat { Constants.Size.ringChart - Constants.Size.ringLine }

    var body: some View {
        ZStack {
            ForEach(Array(fractions.enumerated()), id: \.offset) { index, fraction in
                ScoreRing(
                    progress: shown ? fraction : 0,
                    color: .swSkill(at: index),
                    diameter: outerDiameter - step * CGFloat(index)
                )
            }
            Image(systemName: "waveform")
                .font(.swTitle3)
                .foregroundColor(.swMuted)
        }
        .frame(width: Constants.Size.ringChart, height: Constants.Size.ringChart)
        .onAppear {
            if reduceMotion {
                shown = true
            } else {
                withAnimation(.speakwellGentle) { shown = true }
            }
        }
    }
}

#Preview {
    ScoreRings(fractions: [0.92, 0.91, 0.87])
        .padding()
        .screenBackground()
}
