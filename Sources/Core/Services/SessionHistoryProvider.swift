import Foundation

/// Mock list of past sessions, newest first.
enum SessionHistoryProvider {
    static let sessions: [SessionSummary] = [
        SessionSummary(id: 1, topicTitle: "Is social media bringing us closer?", dayLabel: "Today", minutes: 2),
        SessionSummary(id: 2, topicTitle: "Why curiosity matters", dayLabel: "Yesterday", minutes: 2),
        SessionSummary(id: 3, topicTitle: "Should homework be optional?", dayLabel: "Oct 4", minutes: 2),
        SessionSummary(id: 4, topicTitle: "Can technology make us happier?", dayLabel: "Oct 4", minutes: 2),
        SessionSummary(id: 5, topicTitle: "The value of learning a new skill", dayLabel: "Oct 3", minutes: 2),
        SessionSummary(id: 6, topicTitle: "Is competition good for us?", dayLabel: "Sep 30", minutes: 2),
        SessionSummary(id: 7, topicTitle: "What makes a good leader?", dayLabel: "Sep 29", minutes: 2),
        SessionSummary(id: 8, topicTitle: "Is remote work here to stay?", dayLabel: "Sep 28", minutes: 2)
    ]
}
