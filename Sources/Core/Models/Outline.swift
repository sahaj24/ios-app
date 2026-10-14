import Foundation

/// The user's speech points: written on "Shape your thoughts", reviewed
/// again while speaking.
struct Outline: Equatable {
    var opening: String
    var keyPoints: String
    var closing: String

    /// Mock starting text.
    static let sample = Outline(
        opening: "Connection matters more than screen time.",
        keyPoints: "Long-distance friendships\nShared interests and communities",
        closing: "Use it to connect, not just scroll."
    )

    func text(for section: OutlineSection) -> String {
        switch section {
        case .opening: return opening
        case .keyPoints: return keyPoints
        case .closing: return closing
        }
    }
}
