import SwiftUI

/// Large bold heading at the top of the root screens.
struct ScreenHeading: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.swLargeTitle)
            .tracking(Tracking.largeTitle)
            .foregroundColor(.swText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ScreenHeading(title: "History")
        .padding()
        .screenBackground()
}
