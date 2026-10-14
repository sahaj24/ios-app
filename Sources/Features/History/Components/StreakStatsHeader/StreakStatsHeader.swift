import SwiftUI

/// Top of the Streak page: the current streak (big, lavender) and the longest
/// streak (smaller, white), each with a small label.
struct StreakStatsHeader: View {
    let currentText: String
    let longestText: String

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            stat(value: currentText, label: "Current streak", font: .swStreakDisplay, color: .swLavender)
                .frame(maxWidth: .infinity, alignment: .leading)
            stat(value: longestText, label: "Longest streak", font: .swMetric, color: .swText)
                .frame(width: Constants.Size.streakLongestColumn, alignment: .leading)
        }
    }

    private func stat(value: String, label: String, font: Font, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value)
                .font(font)
                .foregroundColor(color)
                .frame(height: Constants.Size.streakStatLine)
            Text(label)
                .font(.swFootnote)
                .foregroundColor(.swMuted)
        }
    }
}

#Preview {
    StreakStatsHeader(currentText: "5 days", longestText: "8 days")
        .padding()
        .screenBackground()
}
