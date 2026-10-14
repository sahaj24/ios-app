import SwiftUI

/// Read-only look at the points the user wrote, opened from the Speaking
/// screen while they talk.
struct OutlineReviewSheet: View {
    let outline: Outline
    let onClose: () -> Void

    private let sections: [OutlineSection] = [.opening, .keyPoints, .closing]

    var body: some View {
        VStack(spacing: Spacing.s20) {
            HStack {
                Text("Your points")
                    .font(.swTitle2)
                    .foregroundColor(.swText)
                Spacer()
                GlassCircleButton(systemName: "xmark", action: onClose)
                    .accessibilityLabel("Close")
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing: Spacing.sectionGap) {
                    ForEach(sections) { section in
                        card(for: section)
                    }
                }
            }
        }
        .padding(Spacing.s24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.swSurface.ignoresSafeArea())
    }

    private func card(for section: OutlineSection) -> some View {
        let text = outline.text(for: section)
        let isEmpty = text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return VStack(alignment: .leading, spacing: Spacing.s8) {
            Text(section.title)
                .font(.swSubheadlineSemibold)
                .foregroundColor(.swLavender)
            Text(isEmpty ? "Nothing written yet." : text)
                .font(.swBody)
                .foregroundColor(isEmpty ? .swMuted : .swText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(Spacing.cardPadding)
        .background(Color.swBackground, in: RoundedRectangle(cornerRadius: Radius.card, style: .continuous))
    }
}

#Preview {
    OutlineReviewSheet(outline: .sample, onClose: {})
        .screenBackground()
}
