import Foundation

final class GatherThoughtsViewModel: ObservableObject {
    let topicTitle: String

    // The outline, editable.
    @Published var opening: String
    @Published var keyPoints: String
    @Published var closing: String

    /// The section whose editor is open, or nil. Drives the sheet.
    @Published var editingSection: OutlineSection?
    /// The text being edited in the sheet.
    @Published var draft = ""

    @Published private(set) var remainingSeconds: Int
    private let totalSeconds: Int

    /// Told after every save, so the points can be shown on the next screen.
    private let onOutlineChange: (Outline) -> Void

    init(session: PracticeSession, outline: Outline = .sample, onOutlineChange: @escaping (Outline) -> Void = { _ in }) {
        opening = outline.opening
        keyPoints = outline.keyPoints
        closing = outline.closing
        self.onOutlineChange = onOutlineChange
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

    var outline: Outline {
        Outline(opening: opening, keyPoints: keyPoints, closing: closing)
    }

    func text(for section: OutlineSection) -> String {
        outline.text(for: section)
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
        onOutlineChange(outline)
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
