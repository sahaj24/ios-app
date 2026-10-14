import Foundation

final class ProfileViewModel: ObservableObject {
    let profile: UserProfile
    @Published var showsLiveTranscript = true
    @Published var dailyReminder = false
    @Published var hapticFeedback = true

    init(profile: UserProfile = UserProfileProvider.current) {
        self.profile = profile
    }

    var name: String { profile.name }
    var sessionCountText: String { "\(profile.sessionCount)" }
    var averageScoreText: String { "\(profile.averageScore)" }
}
