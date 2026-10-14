import SwiftUI

/// One item of the floating tab bar. The selected item gets a tinted capsule
/// that slides in from the previously selected item.
struct TabBarItem: View {
    let tab: RootTab
    let isSelected: Bool
    let namespace: Namespace.ID
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: Spacing.s4) {
                Image(systemName: tab.symbol)
                    .font(.swTitle3)
                Text(tab.title)
                    .font(.swTabLabel)
            }
            .foregroundColor(isSelected ? .swLavender : .swMuted)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                if isSelected {
                    Capsule()
                        .fill(Color.swTabSelectedFill)
                        .matchedGeometryEffect(id: "tabPill", in: namespace)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

private struct TabBarItemPreview: View {
    @Namespace private var namespace
    var body: some View {
        TabBarItem(tab: .practice, isSelected: true, namespace: namespace) {}
            .frame(width: Constants.Size.tabItemWidth, height: Constants.Size.tabBarHeight)
    }
}

#Preview {
    TabBarItemPreview()
        .screenBackground()
}
