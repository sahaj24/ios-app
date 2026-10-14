import SwiftUI

/// Holds the three tabs and the floating tab bar.
struct RootTabView: View {
    @State private var selectedTab: RootTab = .practice
    @State private var practicePath: [PracticeRoute] = []
    @State private var profilePath: [ProfileRoute] = []

    /// The bar is hidden while the user is inside a pushed sub-screen.
    private var showsTabBar: Bool {
        switch selectedTab {
        case .practice: return practicePath.isEmpty
        case .history: return true
        case .profile: return profilePath.isEmpty
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            content
            if showsTabBar {
                SpeakwellTabBar(selection: $selectedTab)
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case .practice: PracticeFlowView(path: $practicePath)
        case .history: HistoryView()
        case .profile: ProfileFlowView(path: $profilePath)
        }
    }
}

#Preview {
    RootTabView()
}
