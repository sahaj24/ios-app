import SwiftUI

/// Big card with the topic. In "Random topic" it has a shuffle button
/// (roulette) and a small "Pick a topic" action. In "My own topic" the topic
/// is a text box.
///
/// Smoothness rules for the roulette:
/// - the text area has a fixed height, so the card never changes size;
/// - frames change instantly (no per-frame animation), only the landing eases in.
struct TopicCard: View {
    let label: String
    let text: String
    @Binding var ownText: String
    let isEditable: Bool
    let isSpinning: Bool
    let micSymbol: String
    let isMicEnabled: Bool
    let onShuffle: () -> Void
    let onPick: () -> Void
    let onMic: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: Spacing.s12) {
                header
                if isEditable {
                    OwnTopicField(text: $ownText, placeholder: "Write your topic")
                        .padding(.leading, Spacing.s4)
                } else {
                    topicText
                    pickButton
                }
            }
            // Same fixed height in both modes, so the card never jumps.
            .frame(height: Constants.Size.topicCardContentHeight, alignment: .top)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: "bubble.left")
            Text(label)
                .lineLimit(1)
            Spacer()
            if isEditable {
                GlassCircleButton(systemName: micSymbol, action: onMic)
                    .disabled(!isMicEnabled)
                    .accessibilityLabel("Speak your topic")
            } else {
                GlassCircleButton(systemName: "shuffle", action: shuffle)
                    .disabled(isSpinning)
                    .accessibilityLabel("Shuffle topic")
            }
        }
        .font(.swFootnote)
        .foregroundColor(.swMuted)
        .padding(.leading, Spacing.s4)
        .frame(height: Constants.Size.glassButton)
    }

    /// The topic. While spinning the text swaps instantly and is slightly
    /// dimmed; when it lands it eases to full brightness.
    private var topicText: some View {
        Text(text)
            .font(.swTitle2)
            .foregroundColor(.swText)
            .lineLimit(2)
            .minimumScaleFactor(0.75)
            .animation(nil, value: text)
            .opacity(isSpinning ? 0.55 : 1)
            .scaleEffect(isSpinning ? 0.98 : 1, anchor: .leading)
            .animation(reduceMotion ? nil : .easeOut(duration: 0.35), value: isSpinning)
            .frame(maxWidth: .infinity, minHeight: Constants.Size.topicTextHeight, alignment: .topLeading)
            .padding(.leading, Spacing.s4)
    }

    private var pickButton: some View {
        Button(action: onPick) {
            Label("Pick a topic", systemImage: "list.bullet")
                .font(.swSubheadlineSemibold)
                .foregroundColor(.swLavender)
                .padding(.leading, Spacing.s4)
                .frame(height: Constants.Size.glassButton, alignment: .leading)
                .contentShape(Rectangle())
        }
        .buttonStyle(.speakwellPressable)
    }

    private func shuffle() {
        onShuffle()
    }
}

#Preview {
    TopicCard(
        label: "Suggested topic",
        text: "Is social media bringing us closer?",
        ownText: .constant(""),
        isEditable: false,
        isSpinning: false,
        micSymbol: "mic.fill",
        isMicEnabled: true,
        onShuffle: {},
        onPick: {},
        onMic: {}
    )
    .padding()
    .screenBackground()
}
