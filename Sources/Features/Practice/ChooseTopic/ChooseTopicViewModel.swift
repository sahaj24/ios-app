import Foundation

final class ChooseTopicViewModel: ObservableObject {
    @Published var mode: TopicMode = .random
    @Published private(set) var topic: Topic
    @Published private(set) var source: TopicSource = .suggested
    /// True while the roulette is spinning.
    @Published private(set) var isSpinning = false
    /// What the user typed on the "My own topic" tab.
    @Published var ownTopic = ""
    @Published var showsTopicPicker = false
    @Published private(set) var prepOption = TimeOption.preset(seconds: Constants.Session.defaultSeconds)
    @Published private(set) var speakOption = TimeOption.preset(seconds: Constants.Session.defaultSeconds)
    /// Set to show the custom time sheet for that kind; nil hides it.
    @Published var customSheet: TimeKind?

    /// The running roulette. Tests can await it.
    private(set) var spinTask: Task<Void, Never>?
    /// 1 = normal speed, 0 = no waiting (used by tests).
    private let spinSpeed: Double

    init(topic: Topic = TopicProvider.randomTopic(), spinSpeed: Double = 1) {
        self.topic = topic
        self.spinSpeed = spinSpeed
    }

    // MARK: Card text

    var cardLabel: String {
        guard mode == .random else { return "Your topic" }
        switch source {
        case .suggested: return "Suggested topic"
        case .category(let category): return category.title
        case .picked: return "Picked topic"
        }
    }

    var cardText: String {
        topic.title
    }

    /// True on the "My own topic" tab, where the card is a text box.
    var isOwnTopic: Bool {
        mode == .own
    }

    /// Own topic without spaces around it.
    var trimmedOwnTopic: String {
        ownTopic.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Start needs a topic: always true for random, text needed for own.
    var canStart: Bool {
        !isOwnTopic || !trimmedOwnTopic.isEmpty
    }

    // MARK: Topic choice

    /// Spin the roulette (or jump straight to a new topic when `animated` is
    /// false). Draws from the current category, or from all topics.
    func shuffleTopic(animated: Bool = true, startDelay: TimeInterval = 0) {
        guard !isSpinning else { return }
        if source == .picked { source = .suggested }
        let category = source.category

        guard animated else {
            topic = TopicProvider.randomTopic(in: category, excluding: topic)
            return
        }
        let pool = category?.topics ?? TopicProvider.allTopics
        spin(RouletteSpin.make(pool: pool, excluding: topic), startDelay: startDelay)
    }

    func openTopicPicker() {
        showsTopicPicker = true
    }

    /// The user chose one topic by hand.
    func pick(_ chosen: Topic) {
        cancelSpin()
        topic = chosen
        source = .picked
        showsTopicPicker = false
    }

    /// The user asked for a random topic from `category` (nil = all topics).
    func randomTopic(in category: TopicCategory?, animated: Bool = true) {
        cancelSpin()
        source = category.map(TopicSource.category) ?? .suggested
        showsTopicPicker = false
        // Wait for the sheet to close so the spin is visible.
        shuffleTopic(animated: animated, startDelay: 0.4)
    }

    // MARK: Times

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

    /// The topic to speak about: the typed one on the own tab, else the shown one.
    private var sessionTopic: Topic {
        guard isOwnTopic, !trimmedOwnTopic.isEmpty else { return topic }
        return Topic(id: -1, title: trimmedOwnTopic, categoryID: "own")
    }

    func makeSession() -> PracticeSession {
        PracticeSession(topic: sessionTopic, prepSeconds: prepOption.seconds, speakSeconds: speakOption.seconds)
    }

    // MARK: Roulette

    private func spin(_ plan: RouletteSpin, startDelay: TimeInterval) {
        isSpinning = true
        let speed = spinSpeed
        spinTask = Task { @MainActor [weak self] in
            await Self.wait(startDelay * speed)
            for (frame, delay) in zip(plan.frames, plan.delays) {
                await Self.wait(delay * speed)
                guard let self, !Task.isCancelled else { return }
                self.topic = frame
            }
            self?.isSpinning = false
        }
    }

    private func cancelSpin() {
        spinTask?.cancel()
        spinTask = nil
        isSpinning = false
    }

    private static func wait(_ seconds: TimeInterval) async {
        guard seconds > 0 else { return }
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}
