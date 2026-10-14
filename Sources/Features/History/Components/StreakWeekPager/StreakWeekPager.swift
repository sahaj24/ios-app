import SwiftUI

/// Swipeable weeks (older on the left) with page dots underneath.
struct StreakWeekPager: View {
    let weeks: [StreakWeek]
    @Binding var selection: Int
    let onEarlier: () -> Void
    let onNewer: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: Spacing.s12) {
            TabView(selection: $selection) {
                ForEach(Array(weeks.enumerated()), id: \.offset) { index, week in
                    StreakWeekPage(week: week)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: Constants.Size.streakWeekHeight)
            StreakPageDots(
                count: weeks.count,
                selection: selection,
                onEarlier: { animated(onEarlier) },
                onNewer: { animated(onNewer) }
            )
        }
        .padding(.horizontal, Spacing.s16)
    }

    /// Slides to the new page with a smooth spring (or instantly with Reduce Motion).
    private func animated(_ change: () -> Void) {
        withAnimation(Motion.gated(.speakwellSpring, reduceMotion: reduceMotion), change)
    }
}

#Preview {
    StreakWeekPager(
        weeks: StreakProvider.current.weeks,
        selection: .constant(2),
        onEarlier: {},
        onNewer: {}
    )
    .screenBackground()
}
