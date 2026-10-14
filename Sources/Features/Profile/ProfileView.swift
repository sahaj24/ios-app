import SwiftUI

/// Screen 7: who you are, your stats and a few settings (mock only).
struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    let onOpenDisplayAccessibility: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: Spacing.sectionGap) {
                ScreenHeading(title: "Profile")
                ProfileHeader(name: viewModel.name)
                    .padding(.vertical, Spacing.s4)
                HStack(spacing: Spacing.sectionGap) {
                    StatTile(symbol: "waveform", label: "Sessions", value: viewModel.sessionCountText)
                    StatTile(symbol: "chart.line.uptrend.xyaxis", label: "Average score", value: viewModel.averageScoreText)
                }
                SettingsSectionLabel(title: "Practice")
                practiceSettings
                SettingsSectionLabel(title: "App")
                appSettings
            }
            .padding(.horizontal, Spacing.screenHorizontal)
            .padding(.top, Spacing.s32 * 2)
            .padding(.bottom, Constants.Size.tabBarClearance)
        }
        .screenBackground()
    }

    private var practiceSettings: some View {
        GlassCard(padding: 0, radius: Radius.row) {
            VStack(spacing: 0) {
                SettingsToggleRow(symbol: "bubble.left", title: "Show live transcript", isOn: $viewModel.showsLiveTranscript)
                SpeakwellDivider(color: .swBorder).padding(.leading, Spacing.cardPadding)
                SettingsToggleRow(symbol: "bell", title: "Daily reminder", isOn: $viewModel.dailyReminder)
                SpeakwellDivider(color: .swBorder).padding(.leading, Spacing.cardPadding)
                SettingsToggleRow(symbol: "hand.tap", title: "Haptic feedback", isOn: $viewModel.hapticFeedback)
            }
        }
    }

    private var appSettings: some View {
        GlassCard(padding: 0, radius: Radius.row) {
            VStack(spacing: 0) {
                SettingsLinkRow(symbol: "circle.lefthalf.filled", title: "Appearance", value: "System")
                SpeakwellDivider(color: .swBorder).padding(.leading, Spacing.cardPadding)
                Button(action: onOpenDisplayAccessibility) {
                    SettingsLinkRow(symbol: "textformat.size", title: "Display & Accessibility")
                }
                .buttonStyle(.speakwellPressable)
            }
        }
    }
}

#Preview {
    ProfileView(onOpenDisplayAccessibility: {})
        .screenBackground()
}
