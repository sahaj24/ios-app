import SwiftUI

/// Big card with the suggested topic and a shuffle button.
/// Shuffling crossfades the topic text and turns the shuffle icon.
struct TopicCard: View {
    let label: String
    let text: String
    let showsShuffle: Bool
    let onShuffle: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var shuffleTurns = 0

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: Spacing.s12) {
                HStack {
                    Image(systemName: "bubble.left")
                    Text(label)
                    Spacer()
                    if showsShuffle {
                        GlassCircleButton(systemName: "shuffle", action: shuffle)
                            .rotationEffect(.degrees(Double(shuffleTurns) * 180))
                    }
                }
                .font(.swFootnote)
                .foregroundColor(.swMuted)
                .padding(.leading, Spacing.s4)
                .frame(height: Constants.Size.glassButton)
                Text(text)
                    .font(.swTitle2)
                    .foregroundColor(.swText)
                    .padding(.leading, Spacing.s4)
                    .contentTransition(.opacity)
                    .animation(reduceMotion ? nil : .speakwellStandard, value: text)
            }
            .frame(minHeight: Constants.Size.topicCardMinHeight - Spacing.cardPadding * 2, alignment: .top)
        }
    }

    private func shuffle() {
        if !reduceMotion {
            withAnimation(.speakwellStandard) { shuffleTurns += 1 }
        }
        onShuffle()
    }
}

#Preview {
    TopicCard(label: "Suggested topic", text: "Is social media bringing us closer?", showsShuffle: true, onShuffle: {})
        .padding()
        .screenBackground()
}
