import SwiftUI

/// Four small page dots. Tapping the left half shows the earlier week and the
/// right half the newer week (two 64x44 targets, as in the design).
struct StreakPageDots: View {
    let count: Int
    let selection: Int
    let onEarlier: () -> Void
    let onNewer: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: Constants.Size.streakDotGap) {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .fill(index == selection ? Color.swLavender : Color.swMuted.opacity(0.4))
                    .frame(width: Constants.Size.streakDot, height: Constants.Size.streakDot)
            }
        }
        .animation(Motion.gated(.speakwellQuick, reduceMotion: reduceMotion), value: selection)
        .frame(
            width: Constants.Size.streakPageTargetWidth * 2,
            height: Constants.Size.streakPageTargetHeight
        )
        .overlay(targets)
        .frame(maxWidth: .infinity)
    }

    private var targets: some View {
        HStack(spacing: 0) {
            target(label: "Earlier week", action: onEarlier)
            target(label: "Newer week", action: onNewer)
        }
    }

    private func target(label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Color.clear
                .frame(width: Constants.Size.streakPageTargetWidth, height: Constants.Size.streakPageTargetHeight)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

#Preview {
    StreakPageDots(count: 4, selection: 2, onEarlier: {}, onNewer: {})
        .padding()
        .screenBackground()
}
