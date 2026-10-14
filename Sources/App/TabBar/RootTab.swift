import Foundation

/// The three tabs of the app.
enum RootTab: CaseIterable, Identifiable {
    case practice
    case history
    case profile

    var id: Self { self }

    var title: String {
        switch self {
        case .practice: return "Practice"
        case .history: return "History"
        case .profile: return "Profile"
        }
    }

    /// Note: the History symbol needs iOS 17 to render; it is the symbol the design uses.
    var symbol: String {
        switch self {
        case .practice: return "waveform"
        case .history: return "clock.arrow.trianglehead.counterclockwise.rotate.90"
        case .profile: return "person.crop.circle"
        }
    }
}
