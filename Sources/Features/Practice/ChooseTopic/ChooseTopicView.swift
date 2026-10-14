import SwiftUI

/// Screen 1: pick a topic and the preparation / speaking times.
struct ChooseTopicView: View {
    @ObservedObject var viewModel: ChooseTopicViewModel
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: Spacing.s16) {
            ScreenHeading(title: "Choose Your Topic")
            SegmentedToggle(selection: $viewModel.mode)
            TopicCard(
                label: viewModel.cardLabel,
                text: viewModel.cardText,
                showsShuffle: viewModel.showsShuffle,
                onShuffle: viewModel.shuffleTopic
            )
            HStack(spacing: Spacing.sectionGap) {
                timeChip(.preparation)
                timeChip(.speaking)
            }
            Spacer()
            PrimaryButton(title: "Start", action: onStart)
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .padding(.top, Spacing.s32 * 2)
        .padding(.bottom, Constants.Size.tabBarClearance)
        .screenBackground()
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
