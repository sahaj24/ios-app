import SwiftUI

/// One page of the streak pager: the date range, "6/7 days", and seven days.
struct StreakWeekPage: View {
    let week: StreakWeek

    var body: some View {
        VStack(spacing: Spacing.s12) {
            HStack {
                Text(week.title)
                    .font(.swFootnoteSemibold)
                    .foregroundColor(.swText)
                Spacer()
                Text(week.countText)
                    .font(.swCaption)
                    .foregroundColor(.swLavender)
            }
            HStack(spacing: 0) {
                ForEach(week.days) { day in
                    StreakDayColumn(day: day)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    StreakWeekPage(week: StreakProvider.current.weeks[2])
        .padding()
        .screenBackground()
}
