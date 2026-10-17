import SwiftUI

/// One past session shown as a card, with a star when it is a favorite.
struct SessionRow: View {
    let session: SessionSummary
    let isFavorite: Bool

    var body: some View {
        GlassCard(padding: Spacing.s16) {
            ListRow(title: session.topicTitle, caption: session.caption, isFavorite: isFavorite)
        }
    }
}

#Preview {
    SessionRow(session: SessionHistoryProvider.sessions[0], isFavorite: true)
        .padding()
        .screenBackground()
}
