import SwiftUI

/// "Speech skills" card: concentric rings on the left, legend on the right.
struct SpeechSkillsCard: View {
    let skills: [SkillScore]

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: Spacing.s12) {
                HStack {
                    Text("Speech skills")
                        .font(.swHeadline)
                        .foregroundColor(.swText)
                    Spacer()
                    Text("Scores / 100")
                        .font(.swFootnote)
                        .foregroundColor(.swMuted)
                }
                HStack(alignment: .center, spacing: Spacing.s24) {
                    ScoreRings(fractions: skills.map(\.fraction))
                    VStack(alignment: .leading, spacing: Spacing.s12) {
                        ForEach(Array(skills.enumerated()), id: \.offset) { index, skill in
                            SkillLegendRow(name: skill.name, value: skill.value, color: .swSkill(at: index))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SpeechSkillsCard(skills: SpeechScoreProvider.latest.skills)
        .padding()
        .screenBackground()
}
