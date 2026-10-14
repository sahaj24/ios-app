import Foundation

final class ReadyToSpeakViewModel: ObservableObject {
    let topicTitle: String
    @Published private(set) var isRecording = false
    @Published private(set) var elapsedSeconds = 0

    private let speakSeconds: Int
    private let onFinish: () -> Void

    init(session: PracticeSession, onFinish: @escaping () -> Void) {
        topicTitle = session.topic.title
        speakSeconds = session.speakSeconds
        self.onFinish = onFinish
    }

    /// "0:00"
    var timerText: String {
        TimeFormatter.clockText(seconds: elapsedSeconds)
    }

    var titleText: String {
        isRecording ? "Tap to stop speaking" : "Tap to start speaking"
    }

    /// "2 minutes to speak", "1 minute 30 seconds to speak"
    var limitText: String {
        "\(TimeFormatter.longDurationText(seconds: speakSeconds)) to speak"
    }

    var hintText: String {
        isRecording ? "Tap when you're done." : "Start when you're ready."
    }

    /// First tap starts, second tap finishes.
    func toggleRecording() {
        if isRecording {
            isRecording = false
            onFinish()
        } else {
            isRecording = true
        }
    }

    /// Called once per second by the view. Only counts while recording.
    func tick() {
        guard isRecording else { return }
        elapsedSeconds += 1
        if elapsedSeconds >= speakSeconds {
            isRecording = false
            onFinish()
        }
    }
}
