import SwiftUI

/// "Next milestone": a seal badge with the target day count and a short note.
struct StreakMilestone: View {
    let days: Int
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s8) {
            Text("Next milestone")
                .font(.swHeadline)
                .foregroundColor(.swText)
            HStack(spacing: Spacing.s16) {
                badge
                VStack(alignment: .leading, spacing: Spacing.s8) {
                    Text(title)
                        .font(.swHeadline)
                        .foregroundColor(.swText)
                    Text(detail)
                        .font(.swFootnote)
                        .foregroundColor(.swMuted)
                }
                Spacer(minLength: 0)
            }
        }
    }

    /// Outlined seal with the day count in the middle.
    private var badge: some View {
        ZStack {
            Image(systemName: "seal")
                .font(.system(size: Constants.Size.milestoneSeal))
            Text("\(days)")
                .font(.swMetric)
        }
        .foregroundColor(.swLavender)
        .frame(width: Constants.Size.milestoneBadge, height: Constants.Size.milestoneBadge)
        .accessibilityHidden(true)
    }
}

#Preview {
    StreakMilestone(days: 9, title: "9-day streak", detail: "4 more days to beat your longest streak.")
        .padding()
        .screenBackground()
}
