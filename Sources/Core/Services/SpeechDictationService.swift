import AVFoundation
import Foundation
import Speech

/// Turns speech into text (live, partial results) for dictation fields.
/// Usage: `requestPermission`, then `start`, then `stop`.
final class SpeechDictationService {
    private let recognizer = SFSpeechRecognizer(locale: .current)
    private lazy var engine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var onFinish: (() -> Void)?

    /// Asks for speech recognition and microphone access. Calls back on the main queue.
    func requestPermission(_ completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            guard status == .authorized else {
                DispatchQueue.main.async { completion(false) }
                return
            }
            let finish: (Bool) -> Void = { granted in
                DispatchQueue.main.async { completion(granted) }
            }
            if #available(iOS 17, *) {
                AVAudioApplication.requestRecordPermission(completionHandler: finish)
            } else {
                AVAudioSession.sharedInstance().requestRecordPermission(finish)
            }
        }
    }

    /// Starts listening. `onText` gets the full transcript so far (main queue).
    /// `onFinish` is called once when recognition ends on its own.
    func start(onText: @escaping (String) -> Void, onFinish: @escaping () -> Void) throws {
        stop()
        guard let recognizer, recognizer.isAvailable else { throw DictationError.unavailable }

        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.record, mode: .measurement, options: .duckOthers)
        try session.setActive(true, options: .notifyOthersOnDeactivation)

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        self.request = request
        self.onFinish = onFinish

        let input = engine.inputNode
        input.installTap(onBus: 0, bufferSize: 1024, format: input.outputFormat(forBus: 0)) { buffer, _ in
            request.append(buffer)
        }
        engine.prepare()
        try engine.start()

        task = recognizer.recognitionTask(with: request) { [weak self] result, error in
            DispatchQueue.main.async {
                if let result { onText(result.bestTranscription.formattedString) }
                if error != nil || result?.isFinal == true { self?.finish() }
            }
        }
    }

    /// Stops listening without calling `onFinish`.
    func stop() {
        onFinish = nil
        teardown()
    }

    private func finish() {
        let callback = onFinish
        onFinish = nil
        teardown()
        callback?()
    }

    private func teardown() {
        if engine.isRunning {
            engine.stop()
            engine.inputNode.removeTap(onBus: 0)
        }
        request?.endAudio()
        task?.cancel()
        request = nil
        task = nil
    }

    enum DictationError: Error {
        case unavailable
    }
}
