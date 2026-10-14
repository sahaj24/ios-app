import Foundation

final class GatherThoughtsViewModel: ObservableObject {
    let topicTitle: String

    // The outline, now editable.
    @Published var opening = "Connection matters more than screen time."
    @Published var keyPoints = "Long-distance friendships\nShared interests and communities"
    @Published var closing = "Use it to connect, not just scroll."

    /// The section whose editor is open, or nil. Drives the sheet.
    @Published var editingSection: OutlineSection?
    /// The text being edited in the sheet.
    @Published var draft = ""

    @Published private(set) var remainingSeconds: Int
    private let totalSeconds: Int

    init(session: PracticeSession) {
        topicTitle = session.topic.title
        totalSeconds = session.prepSeconds
        remainingSeconds = session.prepSeconds
    }

    /// "2:00"
    var remainingText: String {
        TimeFormatter.clockText(seconds: remainingSeconds)
    }

    /// 1 at the start, 0 when time is up.
    var progress: Double {
        guard totalSeconds > 0 else { return 0 }
        return Double(remainingSeconds) / Double(totalSeconds)
    }

    func text(for section: OutlineSection) -> String {
        switch section {
        case .opening: return opening
        case .keyPoints: return keyPoints
        case .closing: return closing
        }
    }

    /// Open the editor for `section`, pre-filled with its current text.
    func edit(_ section: OutlineSection) {
        draft = text(for: section)
        editingSection = section
    }

    /// Save the draft back to the section being edited.
    func save() {
        guard let section = editingSection else { return }
        let trimmed = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        switch section {
        case .opening: opening = trimmed
        case .keyPoints: keyPoints = trimmed
        case .closing: closing = trimmed
        }
        editingSection = nil
    }

    func cancelEdit() {
        editingSection = nil
    }

    /// Called once per second by the view.
    func tick() {
        guard remainingSeconds > 0 else { return }
        remainingSeconds -= 1
    }
}
