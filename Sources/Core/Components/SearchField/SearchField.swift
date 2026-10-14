import SwiftUI

/// Rounded dark search box with a magnifier and a clear button.
struct SearchField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        HStack(spacing: Spacing.s8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.swMuted)
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.swMuted))
                .font(.swBody)
                .foregroundColor(.swText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.search)
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.swMuted)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Clear search")
            }
        }
        .padding(.horizontal, Spacing.s16)
        .frame(height: Constants.Size.glassButton)
        .background(Color.swRaised.opacity(0.7), in: Capsule())
        .overlay(Capsule().strokeBorder(Color.swBorder, lineWidth: Constants.Size.hairline))
    }
}

#Preview {
    SearchField(text: .constant(""), placeholder: "Search all topics")
        .padding()
        .screenBackground()
}
