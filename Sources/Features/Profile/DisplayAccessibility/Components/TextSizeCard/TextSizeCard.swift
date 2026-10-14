import SwiftUI

/// Card with a text-size slider and a sample sentence.
struct TextSizeCard: View {
    @Binding var value: Double
    let label: String

    var body: some View {
        GlassCard(radius: Radius.row) {
            VStack(alignment: .leading, spacing: Spacing.s16) {
                HStack {
                    Text("Text size")
                        .font(.swHeadline)
                        .foregroundColor(.swText)
                    Spacer()
                    Text(label)
                        .font(.swSubheadline)
                        .foregroundColor(.swMuted)
                }
                Text("Your voice. Your pace.")
                    .font(.swTitle3)
                    .foregroundColor(.swText)
                HStack(spacing: Spacing.s12) {
                    Text("A")
                        .font(.swFootnote)
                        .foregroundColor(.swMuted)
                    Slider(value: $value, in: 0...4, step: 1)
                        .tint(.swLavender)
                    Text("A")
                        .font(.swTitle)
                        .foregroundColor(.swMuted)
                }
            }
        }
    }
}

#Preview {
    TextSizeCard(value: .constant(2), label: "Default")
        .padding()
        .screenBackground()
}
