import Foundation

final class ChooseTopicViewModel: ObservableObject {
    @Published var mode: TopicMode = .random
    @Published private(set) var topic = TopicProvider.defaultTopic
    @Published private(set) var prepOption = TimeOption.preset(seconds: Constants.Session.defaultSeconds)
    @Published private(set) var speakOption = TimeOption.preset(seconds: Constants.Session.defaultSeconds)
    /// Set to show the custom time sheet for that kind; nil hides it.
    @Published var customSheet: TimeKind?

    var cardLabel: String {
        mode == .random ? "Suggested topic" : "Your topic"
    }

    var cardText: String {
        mode == .random ? topic.title : "Write or dictate your topic"
    }

    var showsShuffle: Bool {
        mode == .random
    }

    func shuffleTopic() {
        topic = TopicProvider.randomTopic(excluding: topic)
    }

    func option(for kind: TimeKind) -> TimeOption {
        kind == .preparation ? prepOption : speakOption
    }

    /// Text shown on the chip, e.g. "2 min".
    func label(for kind: TimeKind) -> String {
        option(for: kind).label
    }

    func select(_ option: TimeOption, for kind: TimeKind) {
        switch kind {
        case .preparation: prepOption = option
        case .speaking: speakOption = option
        }
    }

    func beginCustom(for kind: TimeKind) {
        customSheet = kind
    }

    /// Called by the sheet's confirm button. Values outside the limits are clamped.
    func applyCustom(seconds: Int, for kind: TimeKind) {
        select(.custom(seconds: seconds, in: kind.range), for: kind)
        customSheet = nil
    }

    func makeSession() -> PracticeSession {
        PracticeSession(topic: topic, prepSeconds: prepOption.seconds, speakSeconds: speakOption.seconds)
    }
}
