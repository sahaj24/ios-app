import SwiftUI

/// Screen 6: list of past sessions. The "Streak" segment is a placeholder for now.
struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()

    var body: some View {
        VStack(spacing: Spacing.s16) {
            ScreenHeading(title: "History")
            SegmentedToggle(selection: $viewModel.segment)
            switch viewModel.segment {
            case .sessions: sessionList
            case .streak: streakContent
            }
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .padding(.top, Spacing.s32 * 2)
        .screenBackground()
    }

    private var streakContent: some View {
        ScrollView(showsIndicators: false) {
            StreakView(
                summary: viewModel.streak,
                selectedWeek: $viewModel.selectedWeek,
                onEarlier: viewModel.showEarlierWeek,
                onNewer: viewModel.showNewerWeek
            )
            .padding(.bottom, Constants.Size.tabBarClearance)
        }
    }

    private var sessionList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(Array(viewModel.sessions.enumerated()), id: \.element.id) { index, session in
                    ListRow(title: session.topicTitle, caption: session.caption)
                        .padding(.vertical, Spacing.s24)
                        .appearRise(index: index)
                    SpeakwellDivider()
                        .padding(.leading, Constants.Size.iconCircle + Spacing.s12)
                }
            }
            .padding(.bottom, Constants.Size.tabBarClearance)
        }
    }
}

#Preview {
    HistoryView()
        .screenBackground()
}
