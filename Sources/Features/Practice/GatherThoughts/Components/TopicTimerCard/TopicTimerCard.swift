import SwiftUI

/// "Your topic" card with the countdown ring on the right.
struct TopicTimerCard: View {
    let topicTitle: String
    let remainingText: String
    let progress: Double

    var body: some View {
        GlassCard {
            HStack {
                VStack(alignment: .leading, spacing: Spacing.s8) {
                    Text("Your topic")
                        .font(.swFootnote)
                        .foregroundColor(.swMuted)
                    Text(topicTitle)
                        .font(.swTitle3)
                        .foregroundColor(.swText)
                }
                .padding(.trailing, Spacing.s16)
                Spacer()
                CountdownRing(remainingText: remainingText, progress: progress)
            }
        }
    }
}

#Preview {
    TopicTimerCard(topicTitle: "Is social media bringing us closer?", remainingText: "2:00", progress: 1)
        .padding()
        .screenBackground()
}
