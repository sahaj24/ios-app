import SwiftUI

/// Small card showing a time ("2 min") with a menu of presets and a Custom row.
struct TimeChip: View {
    let kind: TimeKind
    let selected: TimeOption
    let onSelect: (TimeOption) -> Void
    let onCustom: () -> Void

    var body: some View {
        Menu {
            ForEach(kind.presets, id: \.self) { seconds in
                row(TimeOption.preset(seconds: seconds).longLabel,
                    isChecked: selected == .preset(seconds: seconds)) {
                    onSelect(.preset(seconds: seconds))
                }
            }
            row("Custom", isChecked: selected.isCustom, action: onCustom)
        } label: {
            GlassCard(padding: Spacing.s12, radius: Radius.chip) {
                VStack(alignment: .leading, spacing: Spacing.s4) {
                    Text(kind.title)
                        .font(.swCaption)
                        .foregroundColor(.swMuted)
                    HStack(spacing: Spacing.s8) {
                        Image(systemName: kind.symbol)
                        Text(selected.label)
                            .font(.swHeadline)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.swCaption)
                            .foregroundColor(.swMuted)
                    }
                    .foregroundColor(.swText)
                }
            }
            .frame(height: Constants.Size.chipHeight)
        }
        .buttonStyle(.plain)
    }

    /// One menu row, with a checkmark when it is the active choice.
    private func row(_ title: String, isChecked: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            if isChecked {
                Label(title, systemImage: "checkmark")
            } else {
                Text(title)
            }
        }
    }
}

#Preview {
    TimeChip(kind: .preparation, selected: .preset(seconds: 120), onSelect: { _ in }, onCustom: {})
        .padding()
        .screenBackground()
}
