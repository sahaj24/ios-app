import SwiftUI

/// Display & Accessibility settings (mock). Reached from the Profile tab.
struct DisplayAccessibilityView: View {
    @StateObject private var viewModel = DisplayAccessibilityViewModel()
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScreenNavBar(title: "Display & Accessibility", onBack: onBack)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Spacing.sectionGap) {
                    SettingsSectionLabel(title: "Display")
                    TextSizeCard(value: $viewModel.textSize, label: viewModel.textSizeLabel)
                    SettingsSectionLabel(title: "Accessibility")
                    accessibilitySettings
                }
                .padding(.top, Spacing.s20)
                .padding(.bottom, Constants.Size.tabBarClearance)
            }
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .screenBackground()
    }

    private var accessibilitySettings: some View {
        GlassCard(padding: 0, radius: Radius.row) {
            VStack(spacing: 0) {
                SettingsToggleRow(symbol: "figure.walk", title: "Reduce motion", isOn: $viewModel.reduceMotion)
                SpeakwellDivider(color: .swBorder).padding(.leading, Spacing.cardPadding)
                SettingsToggleRow(symbol: "square.on.square", title: "Reduce transparency", isOn: $viewModel.reduceTransparency)
            }
        }
    }
}

#Preview {
    DisplayAccessibilityView(onBack: {})
}
