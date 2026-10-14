import SwiftUI

/// Pill-shaped two-way switch (Random topic / My own topic, Sessions / Streak).
/// The selected pill slides between options with a gentle spring.
struct SegmentedToggle<Option: SegmentOption>: View {
    @Binding var selection: Option

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(Option.allCases), id: \.self) { option in
                segment(for: option)
            }
        }
        .padding(Constants.Size.segmentedInset)
        .frame(height: Constants.Size.segmented)
        .background(Color.swRaised.opacity(0.7), in: Capsule())
        .overlay(Capsule().strokeBorder(Color.swBorder, lineWidth: Constants.Size.hairline))
    }

    private func segment(for option: Option) -> some View {
        let isSelected = option == selection
        return Button {
            withAnimation(Motion.gated(.speakwellSpring, reduceMotion: reduceMotion)) {
                selection = option
            }
        } label: {
            Text(option.title)
                .font(.swHeadline)
                .foregroundColor(isSelected ? .swText : .swMuted)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    if isSelected {
                        Capsule()
                            .fill(Color.swSelected)
                            .matchedGeometryEffect(id: "segmentPill", in: namespace)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

private enum PreviewOption: String, SegmentOption {
    case first = "Random topic"
    case second = "My own topic"
    var title: String { rawValue }
}

#Preview {
    SegmentedToggle(selection: .constant(PreviewOption.first))
        .padding()
        .screenBackground()
}
