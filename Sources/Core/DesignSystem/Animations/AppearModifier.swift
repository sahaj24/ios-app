import SwiftUI

/// Fades content in with a small upward rise the first time it appears.
/// `index` staggers several items; Reduce Motion shows them at once.
private struct AppearModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    let index: Int
    @State private var shown = false

    func body(content: Content) -> some View {
        content
            .opacity(shown ? 1 : 0)
            .offset(y: shown ? 0 : 10)
            .onAppear {
                guard !shown else { return }
                if reduceMotion {
                    shown = true
                } else {
                    withAnimation(.speakwellGentle.delay(Double(min(index, 6)) * 0.04)) {
                        shown = true
                    }
                }
            }
    }
}

extension View {
    /// Calm fade-and-rise on first appear, optionally staggered by `index`.
    func appearRise(index: Int = 0) -> some View {
        modifier(AppearModifier(index: index))
    }
}
