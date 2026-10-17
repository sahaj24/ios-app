import SwiftUI

/// Screen 6: list of past sessions. The "Streak" segment is a placeholder for now.
struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()

    var body: some View {
        VStack(spacing: Spacing.s20) {
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

    @ViewBuilder
    private var sessionList: some View {
        if viewModel.sessions.isEmpty {
            emptyState
        } else {
            List {
                ForEach(Array(viewModel.sessions.enumerated()), id: \.element.id) { index, session in
                    SessionRow(session: session, isFavorite: viewModel.isFavorite(session))
                        .appearRise(index: index)
                        .listRowInsets(EdgeInsets(top: Spacing.s8, leading: 0, bottom: Spacing.s8, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        // Swipe right: star. Swipe left: delete. Long-press shows both.
                        .swipeActions(edge: .leading, allowsFullSwipe: true) { favoriteButton(session) }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) { deleteButton(session) }
                        .contextMenu {
                            favoriteButton(session)
                            deleteButton(session)
                        }
                }
                // Keeps the last card clear of the floating tab bar.
                Color.clear
                    .frame(height: Constants.Size.tabBarClearance)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

    private func favoriteButton(_ session: SessionSummary) -> some View {
        let isFavorite = viewModel.isFavorite(session)
        return Button {
            withAnimation { viewModel.toggleFavorite(session) }
        } label: {
            Label(isFavorite ? "Unstar" : "Star", systemImage: isFavorite ? "star.slash.fill" : "star.fill")
        }
        .tint(.swAccent)
    }

    private func deleteButton(_ session: SessionSummary) -> some View {
        Button(role: .destructive) {
            withAnimation { viewModel.delete(session) }
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
    }

    private var emptyState: some View {
        VStack(spacing: Spacing.s12) {
            Image(systemName: "waveform")
                .font(.swTitle2)
                .foregroundColor(.swLavender)
            Text("No sessions yet")
                .font(.swBody)
                .foregroundColor(.swMuted)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, Constants.Size.tabBarClearance)
    }
}

#Preview {
    HistoryView()
        .screenBackground()
}
