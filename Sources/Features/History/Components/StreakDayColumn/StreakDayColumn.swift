import SwiftUI

/// One day of a streak week: the weekday letter above a date circle.
/// Practised days are filled lavender; other days are a dark circle.
struct StreakDayColumn: View {
    let day: StreakDay

    var body: some View {
        VStack(spacing: Constants.Size.streakDayLabelGap) {
            Text(day.weekday)
                .font(.swCaption)
                .foregroundColor(.swMuted)
                .frame(height: Constants.Size.streakDayLabelHeight)
            Text("\(day.number)")
                .font(day.isPracticed ? .swSubheadlineSemibold : .swSubheadline)
                .foregroundColor(day.isPracticed ? .swInk : .swMuted)
                .frame(width: Constants.Size.streakDayCircle, height: Constants.Size.streakDayCircle)
                .background(day.isPracticed ? Color.swLavender : Color.swRaised, in: Circle())
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(day.number), \(day.isPracticed ? "practised" : "not practised")")
    }
}

#Preview {
    HStack {
        StreakDayColumn(day: StreakDay(weekday: "M", number: 28, isPracticed: true))
        StreakDayColumn(day: StreakDay(weekday: "S", number: 4, isPracticed: false))
    }
    .padding()
    .screenBackground()
}
