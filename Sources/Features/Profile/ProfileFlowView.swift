import SwiftUI

/// Navigation for the Profile tab: Profile -> Display & Accessibility.
struct ProfileFlowView: View {
    @Binding var path: [ProfileRoute]

    var body: some View {
        NavigationStack(path: $path) {
            ProfileView(onOpenDisplayAccessibility: { path.append(.displayAccessibility) })
                .hiddenNavigationBar()
                .navigationDestination(for: ProfileRoute.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(for route: ProfileRoute) -> some View {
        switch route {
        case .displayAccessibility:
            DisplayAccessibilityView(onBack: { path.removeLast() })
                .hiddenNavigationBar()
        }
    }
}
