import Foundation

/// What the user picked on the first screen; handed to the screens that follow.
struct PracticeSession: Equatable {
    let topic: Topic
    let prepSeconds: Int
    let speakSeconds: Int
}
