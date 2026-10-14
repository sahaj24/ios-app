import SwiftUI

/// Green check mark with "Goal reached".
struct GoalBadge: View {
    let text: String

    var body: some View {
        Label(text, systemImage: "checkmark.seal.fill")
            .font(.swSubheadlineSemibold)
            .foregroundColor(.swGreen)
    }
}

#Preview {
    GoalBadge(text: "Goal reached")
        .padding()
        .screenBackground()
}
