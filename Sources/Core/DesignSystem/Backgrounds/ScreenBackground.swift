import SwiftUI

/// The purple glow at the top that fades to near black. Used behind every screen.
struct ScreenBackground: View {
    private let stops: [Gradient.Stop] = [
        .init(color: .swBackgroundTop, location: 0.00),
        .init(color: .swBackgroundGlow1, location: 0.12),
        .init(color: .swBackgroundGlow2, location: 0.23),
        .init(color: .swBackgroundGlow3, location: 0.34),
        .init(color: .swBackgroundMid, location: 0.51),
        .init(color: .swBackground, location: 0.69),
        .init(color: .swBackground, location: 1.00)
    ]

    var body: some View {
        LinearGradient(stops: stops, startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

extension View {
    /// Puts the Speakwell gradient behind this view.
    func screenBackground() -> some View {
        background(ScreenBackground())
    }
}

#Preview {
    ScreenBackground()
}
