import SwiftUI

/// Colored dot, skill name and its score.
struct SkillLegendRow: View {
    let name: String
    let value: Int
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.s8) {
            Circle()
                .fill(color)
                .frame(width: Constants.Size.legendDot, height: Constants.Size.legendDot)
                .padding(.top, Spacing.s8)
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .font(.swSubheadline)
                    .foregroundColor(.swMuted)
                Text("\(value)")
                    .font(.swRingValue)
                    .foregroundColor(color)
            }
        }
    }
}

#Preview {
    SkillLegendRow(name: "Topic relevance", value: 92, color: .swRingTopic)
        .padding()
        .screenBackground()
}
