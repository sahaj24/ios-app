import Foundation

/// Mock signed-in user.
enum UserProfileProvider {
    static let current = UserProfile(name: "Abhinav", sessionCount: 23, averageScore: 82)
}
