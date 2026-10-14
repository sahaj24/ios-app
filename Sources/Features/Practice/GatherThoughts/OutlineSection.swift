import Foundation

/// One editable section of the speech outline on the Gather screen.
enum OutlineSection: String, Identifiable {
    case opening
    case keyPoints
    case closing

    var id: String { rawValue }

    var title: String {
        switch self {
        case .opening: return "Opening statement"
        case .keyPoints: return "Key points"
        case .closing: return "Closing statement"
        }
    }

    /// Prompt shown when the section is empty (card and editor).
    var placeholder: String {
        switch self {
        case .opening: return "How will you introduce your main idea?"
        case .keyPoints: return "Write a reason, an example, or a short story."
        case .closing: return "What should your listener remember?"
        }
    }

    /// Label on the editor's save button.
    var saveTitle: String {
        self == .keyPoints ? "Save Points" : "Save"
    }
}
