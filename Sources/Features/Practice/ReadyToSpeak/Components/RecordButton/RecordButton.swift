import SwiftUI

/// Big round lavender button with a mic (or a stop square while speaking).
/// A soft halo pulses outward while recording.
struct RecordButton: View {
    let isRecording: Bool
    let action: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var pulsing = false

    private var size: CGFloat { Constants.Size.recordButton }

    var body: some View {
        Button(action: action) {
            ZStack {
                if isRecording && !reduceMotion {
                    Circle()
                        .fill(Color.swAccent)
                        .frame(width: size, height: size)
                        .scaleEffect(pulsing ? 1.3 : 1)
                        .opacity(pulsing ? 0 : 0.5)
                }
                Image(systemName: isRecording ? "stop.fill" : "mic")
                    .font(.swLargeTitle)
                    .foregroundColor(.swInk)
                    .frame(width: size, height: size)
                    .background(Color.swAccent, in: Circle())
                    .overlay(
                        Circle().strokeBorder(
                            LinearGradient(
                                colors: [.swAccentHighlight, .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: Constants.Size.hairline
                        )
                    )
            }
        }
        .buttonStyle(.speakwellPressable)
        .onChange(of: isRecording) { recording in
            guard !reduceMotion else { return }
            if recording {
                pulsing = false
                withAnimation(.speakwellPulse) { pulsing = true }
            } else {
                pulsing = false
            }
        }
    }
}

#Preview {
    RecordButton(isRecording: false) {}
        .padding()
        .screenBackground()
}
