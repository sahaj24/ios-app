import SwiftUI

/// Bottom sheet with minutes and seconds wheels. Used for both preparation and speaking time.
struct CustomTimeSheet: View {
    let kind: TimeKind
    let onCancel: () -> Void
    let onDone: (Int) -> Void

    @State private var minutes: Int
    @State private var seconds: Int

    init(kind: TimeKind, initialSeconds: Int, onCancel: @escaping () -> Void, onDone: @escaping (Int) -> Void) {
        self.kind = kind
        self.onCancel = onCancel
        self.onDone = onDone
        let start = TimeOption.custom(seconds: initialSeconds, in: kind.range).seconds
        _minutes = State(initialValue: start / Constants.Session.secondsPerMinute)
        _seconds = State(initialValue: start % Constants.Session.secondsPerMinute)
    }

    /// What Done will apply: the wheels' value pulled inside the allowed range.
    private var clampedSeconds: Int {
        TimeOption.custom(seconds: minutes * Constants.Session.secondsPerMinute + seconds, in: kind.range).seconds
    }

    var body: some View {
        VStack(spacing: Spacing.s16) {
            header
            Text(kind.subtitle)
                .font(.swSubheadline)
                .foregroundColor(.swMuted)
            TimeWheelPicker(minutes: $minutes, seconds: $seconds, minuteValues: kind.minuteValues)
            Text(TimeFormatter.summaryText(seconds: clampedSeconds))
                .font(.swTitle3)
                .foregroundColor(.swText)
            Text(kind.caption)
                .font(.swFootnote)
                .foregroundColor(.swMuted)
        }
        .padding(Spacing.s20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.swSurface.ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            GlassCircleButton(systemName: "xmark", action: onCancel)
            Spacer()
            GlassCircleButton(systemName: "checkmark") { onDone(clampedSeconds) }
        }
        .overlay(
            Text(kind.title)
                .font(.swHeadline)
                .foregroundColor(.swText)
        )
    }
}

#Preview {
    CustomTimeSheet(kind: .preparation, initialSeconds: 120, onCancel: {}, onDone: { _ in })
}
