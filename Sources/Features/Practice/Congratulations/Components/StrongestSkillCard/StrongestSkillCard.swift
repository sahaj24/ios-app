import SwiftUI

/// "Your strongest skill" card with a short sentence.
struct StrongestSkillCard: View {
    let text: String

    var body: some View {
        GlassCard(radius: Radius.row) {
            VStack(alignment: .leading, spacing: Spacing.s8) {
                Label("Your strongest skill", systemImage: "scope")
                    .font(.swHeadline)
                    .foregroundColor(.swText)
                    .labelStyle(GreenIconLabelStyle())
                Text(text)
                    .font(.swCallout)
                    .foregroundColor(.swMuted)
            }
        }
    }
}

/// Label with a green icon and white text.
private struct GreenIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: Spacing.s8) {
            configuration.icon.foregroundColor(.swGreen)
            configuration.title
        }
    }
}

#Preview {
    StrongestSkillCard(text: "Topic relevance: 92. Your ideas stayed close to the subject.")
        .padding()
        .screenBackground()
}
