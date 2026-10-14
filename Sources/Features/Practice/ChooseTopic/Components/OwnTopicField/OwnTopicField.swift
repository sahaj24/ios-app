import SwiftUI

/// Text box for "My own topic". Looks like the topic text on the card and
/// grows up to three lines.
struct OwnTopicField: View {
    @Binding var text: String
    let placeholder: String

    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder).foregroundColor(.swMuted),
            axis: .vertical
        )
        .lineLimit(1...3)
        .font(.swTitle2)
        .foregroundColor(.swText)
        .tint(.swLavender)
        .textInputAutocapitalization(.sentences)
        .frame(maxWidth: .infinity, minHeight: Constants.Size.topicTextHeight, alignment: .topLeading)
        .focused($isFocused)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { isFocused = false }
            }
        }
        .accessibilityLabel("Your topic")
    }
}

#Preview {
    OwnTopicField(text: .constant(""), placeholder: "Write your topic")
        .padding()
        .screenBackground()
}
