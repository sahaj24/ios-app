import SwiftUI

/// Screen 1: pick a topic and the preparation / speaking times.
struct ChooseTopicView: View {
    @ObservedObject var viewModel: ChooseTopicViewModel
    let onStart: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: Spacing.s16) {
            ScreenHeading(title: "Choose Your Topic")
            SegmentedToggle(selection: $viewModel.mode)
            TopicCard(
                label: viewModel.cardLabel,
                text: viewModel.cardText,
                ownText: $viewModel.ownTopic,
                isEditable: viewModel.isOwnTopic,
                isSpinning: viewModel.isSpinning,
                micSymbol: viewModel.micSymbol,
                isMicEnabled: !viewModel.isMicDenied,
                onShuffle: { viewModel.shuffleTopic(animated: !reduceMotion) },
                onPick: viewModel.openTopicPicker,
                onMic: viewModel.toggleDictation
            )
            .sheet(isPresented: $viewModel.showsTopicPicker) { topicPicker }
            HStack(spacing: Spacing.sectionGap) {
                timeChip(.preparation)
                timeChip(.speaking)
            }
            Spacer()
            PrimaryButton(title: "Start", action: onStart)
                .disabled(!viewModel.canStart)
                .opacity(viewModel.canStart ? 1 : 0.4)
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .padding(.top, Spacing.s32 * 2)
        .padding(.bottom, Constants.Size.tabBarClearance)
        .screenBackground()
        .onDisappear(perform: viewModel.stopDictation)
        .sheet(item: $viewModel.customSheet) { kind in
            CustomTimeSheet(
                kind: kind,
                initialSeconds: viewModel.option(for: kind).seconds,
                onCancel: { viewModel.customSheet = nil },
                onDone: { viewModel.applyCustom(seconds: $0, for: kind) }
            )
            .presentationDetents([.height(Constants.Size.customSheetHeight)])
        }
    }

    private var topicPicker: some View {
        TopicPickerSheet(
            onPick: viewModel.pick,
            onRandom: { viewModel.randomTopic(in: $0, animated: !reduceMotion) },
            onClose: { viewModel.showsTopicPicker = false }
        )
        .presentationDetents([.large])
    }

    private func timeChip(_ kind: TimeKind) -> some View {
        TimeChip(
            kind: kind,
            selected: viewModel.option(for: kind),
            onSelect: { viewModel.select($0, for: kind) },
            onCustom: { viewModel.beginCustom(for: kind) }
        )
    }
}

#Preview {
    ChooseTopicView(viewModel: ChooseTopicViewModel(), onStart: {})
        .screenBackground()
}
