import SwiftUI

/// Large light timer text ("0:00").
struct TimerLabel: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.swTimer)
            .foregroundColor(.swMuted)
            .monospacedDigit()
    }
}

#Preview {
    TimerLabel(text: "0:00")
        .padding()
        .screenBackground()
}
