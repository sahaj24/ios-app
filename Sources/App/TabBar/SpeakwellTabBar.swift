import SwiftUI

/// Floating glass tab bar shown on the root screens.
/// The lavender selection capsule slides between tabs with a gentle spring.
struct SpeakwellTabBar: View {
    @Binding var selection: RootTab

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 0) {
            ForEach(RootTab.allCases) { tab in
                TabBarItem(tab: tab, isSelected: tab == selection, namespace: namespace) {
                    withAnimation(Motion.gated(.speakwellSpring, reduceMotion: reduceMotion)) {
                        selection = tab
                    }
                }
            }
        }
        .padding(Constants.Size.segmentedInset)
        .frame(height: Constants.Size.tabBarHeight)
        .background(.ultraThinMaterial, in: Capsule())
        .background(Color.swRaised.opacity(0.5), in: Capsule())
        .overlay(Capsule().strokeBorder(Color.swBorder, lineWidth: Constants.Size.hairline))
        .padding(.horizontal, Constants.Size.tabBarInset)
        .padding(.bottom, Constants.Size.tabBarBottomGap)
    }
}

#Preview {
    SpeakwellTabBar(selection: .constant(.practice))
        .screenBackground()
}
