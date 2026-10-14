import SwiftUI

/// One circular progress ring with rounded ends.
struct ScoreRing: View {
    let progress: Double
    let color: Color
    let diameter: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.swSurface, lineWidth: Constants.Size.ringLine)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: Constants.Size.ringLine, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        .frame(width: diameter, height: diameter)
    }
}

#Preview {
    ScoreRing(progress: 0.92, color: .swRingTopic, diameter: 120)
        .padding()
        .screenBackground()
}
