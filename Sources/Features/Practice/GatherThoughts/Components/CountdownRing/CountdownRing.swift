import SwiftUI

/// Circle that empties as time runs out, with the remaining time inside.
struct CountdownRing: View {
    let remainingText: String
    let progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.swBorder, lineWidth: Constants.Size.countdownLine)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.swRingTopic,
                    style: StrokeStyle(lineWidth: Constants.Size.countdownLine, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 0) {
                Text(remainingText)
                    .font(.swCountdown)
                    .foregroundColor(.swText)
                Text("remaining")
                    .font(.swCaption)
                    .foregroundColor(.swMuted)
            }
        }
        .frame(width: Constants.Size.countdownRing, height: Constants.Size.countdownRing)
    }
}

#Preview {
    CountdownRing(remainingText: "2:00", progress: 1)
        .padding()
        .screenBackground()
}
