import Combine
import SwiftUI

/// Screen 3: tap the mic to start and stop the speech. No audio is recorded yet.
struct ReadyToSpeakView: View {
    @StateObject private var viewModel: ReadyToSpeakViewModel
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let onBack: () -> Void

    init(
        session: PracticeSession,
        outline: Outline = .sample,
        onBack: @escaping () -> Void,
        onFinish: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: ReadyToSpeakViewModel(session: session, outline: outline, onFinish: onFinish))
        self.onBack = onBack
    }

    var body: some View {
        VStack(spacing: 0) {
            ScreenNavBar(
                title: "Speaking",
                onBack: onBack,
                trailingSymbol: "list.bullet.rectangle",
                onTrailing: { viewModel.showsPoints = true }
            )
            Text("YOUR TOPIC")
                .font(.swCaption)
                .tracking(Tracking.eyebrow)
                .foregroundColor(.swMuted)
                .padding(.top, Spacing.s32)
            Text(viewModel.topicTitle)
                .font(.swTitle)
                .foregroundColor(.swText)
                .multilineTextAlignment(.center)
                .padding(.top, Spacing.s12)
            Spacer()
            DottedDivider()
            TimerLabel(text: viewModel.timerText)
                .padding(.top, Spacing.s32)
            Spacer()
            RecordButton(isRecording: viewModel.isRecording, action: viewModel.toggleRecording)
            Text(viewModel.titleText)
                .font(.swHeadline)
                .foregroundColor(.swText)
                .padding(.top, Spacing.s12)
            Text(viewModel.limitText)
                .font(.swFootnote)
                .foregroundColor(.swMuted)
                .padding(.top, Spacing.s12)
            Text(viewModel.hintText)
                .font(.swFootnote)
                .foregroundColor(.swMuted)
                .padding(.top, Spacing.s12)
            Spacer()
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .screenBackground()
        .onReceive(timer) { _ in viewModel.tick() }
        .sheet(isPresented: $viewModel.showsPoints) {
            OutlineReviewSheet(outline: viewModel.outline, onClose: { viewModel.showsPoints = false })
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    ReadyToSpeakView(
        session: ChooseTopicViewModel().makeSession(),
        onBack: {},
        onFinish: {}
    )
}
