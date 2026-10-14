import SwiftUI

/// Screen 4: the overall score and the strongest skill.
struct CongratulationsView: View {
    @StateObject private var viewModel = CongratulationsViewModel()
    let onViewAnalysis: () -> Void
    let onRetry: () -> Void
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: Spacing.sectionGap) {
            GoalBadge(text: viewModel.badgeText)
                .padding(.top, Spacing.s32 * 2)
            Text(viewModel.headline)
                .font(.swTitle)
                .foregroundColor(.swText)
            Spacer()
            LaurelScore(score: viewModel.overall)
                .appearRise()
            Text(viewModel.scoreCaption)
                .font(.swSubheadline)
                .foregroundColor(.swMuted)
            Spacer()
            StrongestSkillCard(text: viewModel.strongestSkillText)
            SecondaryButton(title: "View analysis", action: onViewAnalysis)
            ActionButtonRow(onRetry: onRetry, onDone: onDone)
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .padding(.bottom, Spacing.s12)
        .screenBackground()
    }
}

#Preview {
    CongratulationsView(onViewAnalysis: {}, onRetry: {}, onDone: {})
}
