import SwiftUI

/// Tappable card for one outline section. Shows the current text (or a muted
/// placeholder when empty) and opens the editor when tapped.
struct OutlineSectionCard: View {
    let section: OutlineSection
    let text: String
    let onEdit: () -> Void

    private var isEmpty: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        Button(action: onEdit) {
            GlassCard(radius: Radius.row) {
                VStack(alignment: .leading, spacing: Spacing.s8) {
                    HStack {
                        Text(section.title)
                            .font(.swHeadline)
                        Spacer()
                        Image(systemName: "pencil")
                            .foregroundColor(.swMuted)
                    }
                    .foregroundColor(.swText)
                    Text(isEmpty ? section.placeholder : text)
                        .font(.swBody)
                        .foregroundColor(isEmpty ? .swMuted : .swText)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .buttonStyle(.speakwellPressable)
    }
}

#Preview {
    VStack {
        OutlineSectionCard(section: .opening, text: "Connection matters more than screen time.", onEdit: {})
        OutlineSectionCard(section: .keyPoints, text: "", onEdit: {})
    }
    .padding()
    .screenBackground()
}
