import SwiftUI

/// Bottom sheet for editing one outline section: a title, a close button,
/// a text area, and a save button that is disabled while empty.
struct OutlineEditSheet: View {
    let section: OutlineSection
    @Binding var text: String
    let onCancel: () -> Void
    let onSave: () -> Void

    @FocusState private var focused: Bool

    private var isEmpty: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(spacing: Spacing.s16) {
            HStack {
                Text(section.title)
                    .font(.swTitle2)
                    .foregroundColor(.swText)
                Spacer()
                GlassCircleButton(systemName: "xmark", action: onCancel)
            }
            editor
            PrimaryButton(title: section.saveTitle, action: onSave)
                .disabled(isEmpty)
                .opacity(isEmpty ? 0.5 : 1)
        }
        .padding(Spacing.s24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.swSurface.ignoresSafeArea())
        .onAppear { focused = true }
    }

    private var editor: some View {
        ZStack(alignment: .topLeading) {
            if isEmpty {
                Text(section.placeholder)
                    .font(.swBody)
                    .foregroundColor(.swMuted)
                    .padding(.top, Spacing.s12 + 2)
                    .padding(.leading, Spacing.s12 + 5)
            }
            TextEditor(text: $text)
                .font(.swBody)
                .foregroundColor(.swText)
                .scrollContentBackground(.hidden)
                .focused($focused)
                .padding(Spacing.s12)
                .frame(height: Constants.Size.editorHeight)
        }
        .background(Color.swBackground, in: RoundedRectangle(cornerRadius: Radius.card, style: .continuous))
    }
}

#Preview {
    OutlineEditSheet(section: .keyPoints, text: .constant(""), onCancel: {}, onSave: {})
        .screenBackground()
}
