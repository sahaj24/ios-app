import Combine
import SwiftUI

/// Screen 2: shape the speech while the preparation timer runs.
/// Each outline card opens an editor sheet when tapped.
struct GatherThoughtsView: View {
    @StateObject private var viewModel: GatherThoughtsViewModel
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let onBack: () -> Void
    let onReady: () -> Void

    init(session: PracticeSession, onBack: @escaping () -> Void, onReady: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: GatherThoughtsViewModel(session: session))
        self.onBack = onBack
        self.onReady = onReady
    }

    var body: some View {
        VStack(spacing: Spacing.sectionGap) {
            ScreenNavBar(title: "Shape your thoughts", onBack: onBack)
                .padding(.bottom, Spacing.s4)
            ScrollView(showsIndicators: false) {
                VStack(spacing: Spacing.sectionGap) {
                    TopicTimerCard(
                        topicTitle: viewModel.topicTitle,
                        remainingText: viewModel.remainingText,
                        progress: viewModel.progress
                    )
                    outlineCard(.opening, text: viewModel.opening)
                    outlineCard(.keyPoints, text: viewModel.keyPoints)
                    outlineCard(.closing, text: viewModel.closing)
                }
                .padding(.bottom, Spacing.s8)
            }
            PrimaryButton(title: "Ready to Speak", action: onReady)
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .padding(.bottom, Spacing.s12)
        .screenBackground()
        .onReceive(timer) { _ in viewModel.tick() }
        .sheet(item: $viewModel.editingSection) { section in
            OutlineEditSheet(
                section: section,
                text: $viewModel.draft,
                onCancel: viewModel.cancelEdit,
                onSave: viewModel.save
            )
            .presentationDetents([.medium, .large])
        }
    }

    private func outlineCard(_ section: OutlineSection, text: String) -> some View {
        OutlineSectionCard(section: section, text: text) {
            viewModel.edit(section)
        }
    }
}

#Preview {
    GatherThoughtsView(
        session: ChooseTopicViewModel().makeSession(),
        onBack: {},
        onReady: {}
    )
}
