import SwiftUI

/// Retry and Done side by side at the bottom of the result screens.
struct ActionButtonRow: View {
    let onRetry: () -> Void
    let onDone: () -> Void

    var body: some View {
        HStack(spacing: Spacing.sectionGap) {
            SecondaryButton(title: "Retry", action: onRetry)
            PrimaryButton(title: "Done", action: onDone)
        }
    }
}

#Preview {
    ActionButtonRow(onRetry: {}, onDone: {})
        .padding()
        .screenBackground()
}
