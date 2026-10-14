import SwiftUI

extension View {
    /// Screens draw their own nav bar, so hide the system one (and its back button).
    func hiddenNavigationBar() -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
    }
}
