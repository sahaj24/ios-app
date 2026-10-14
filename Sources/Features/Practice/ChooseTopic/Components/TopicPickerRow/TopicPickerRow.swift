import SwiftUI

/// One tappable row in the topic picker: a category (with a count and a
/// chevron) or a single topic. A thin divider closes each row.
struct TopicPickerRow: View {
    let title: String
    var detail: String?
    var showsChevron = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                HStack(spacing: Spacing.s12) {
                    VStack(alignment: .leading, spacing: Spacing.s4) {
                        Text(title)
                            .font(.swBody)
                            .foregroundColor(.swText)
                            .multilineTextAlignment(.leading)
                        if let detail {
                            Text(detail)
                                .font(.swFootnote)
                                .foregroundColor(.swMuted)
                        }
                    }
                    Spacer(minLength: 0)
                    if showsChevron {
                        Image(systemName: "chevron.right")
                            .font(.system(size: Constants.Size.chevron, weight: .semibold))
                            .foregroundColor(.swMuted)
                    }
                }
                .padding(.vertical, Spacing.s16)
                .contentShape(Rectangle())
                SpeakwellDivider(color: .swBorder)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        TopicPickerRow(title: "Ethics and Moral Dilemmas", detail: "100 topics", showsChevron: true) {}
        TopicPickerRow(title: "Should NATO expand further?") {}
    }
    .padding()
    .screenBackground()
}
