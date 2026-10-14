import SwiftUI

/// Navigation for the Practice tab:
/// Choose topic -> Gather thoughts -> Ready to speak -> Congratulations -> Performance.
struct PracticeFlowView: View {
    @Binding var path: [PracticeRoute]
    @StateObject private var chooseTopic = ChooseTopicViewModel()
    @State private var session = ChooseTopicViewModel().makeSession()

    var body: some View {
        NavigationStack(path: $path) {
            ChooseTopicView(viewModel: chooseTopic, onStart: start)
                .hiddenNavigationBar()
                .navigationDestination(for: PracticeRoute.self, destination: destination)
        }
    }

    @ViewBuilder
    private func destination(for route: PracticeRoute) -> some View {
        switch route {
        case .gatherThoughts:
            GatherThoughtsView(
                session: session,
                onBack: goBack,
                onReady: { path.append(.readyToSpeak) }
            )
            .hiddenNavigationBar()
        case .readyToSpeak:
            ReadyToSpeakView(
                session: session,
                onBack: goBack,
                onFinish: { path.append(.congratulations) }
            )
            .hiddenNavigationBar()
        case .congratulations:
            CongratulationsView(
                onViewAnalysis: { path.append(.performance) },
                onRetry: retry,
                onDone: done
            )
            .hiddenNavigationBar()
        case .performance:
            PerformanceView(onBack: goBack, onRetry: retry, onDone: done)
                .hiddenNavigationBar()
        }
    }

    private func start() {
        session = chooseTopic.makeSession()
        path.append(.gatherThoughts)
    }

    private func goBack() {
        path.removeLast()
    }

    /// Back to "Ready to speak" with a fresh recorder.
    private func retry() {
        path = [.gatherThoughts, .readyToSpeak]
    }

    /// Back to "Choose a topic".
    private func done() {
        path = []
    }
}
