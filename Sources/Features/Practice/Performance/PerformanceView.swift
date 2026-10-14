import SwiftUI

/// Screen 5: skill scores and tips. The rows have no destination yet.
struct PerformanceView: View {
    @StateObject private var viewModel = PerformanceViewModel()
    let onBack: () -> Void
    let onRetry: () -> Void
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScreenNavBar(title: "Your performance", onBack: onBack)
                .padding(.horizontal, Spacing.screenHorizontal)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Spacing.sectionGap) {
                    SpeechSkillsCard(skills: viewModel.skills)
                    NavigationRowCard(title: viewModel.reviewTitle, subtitle: viewModel.reviewSubtitle)
                    Text("How to get better")
                        .font(.swTitle2)
                        .foregroundColor(.swText)
                        .padding(.top, Spacing.s12)
                    ForEach(viewModel.tips) { tip in
                        NavigationRowCard(title: tip.title, subtitle: tip.detail)
                    }
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.top, Spacing.s20)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            ActionButtonRow(onRetry: onRetry, onDone: onDone)
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, Spacing.s12)
        }
        .screenBackground()
    }
}

#Preview {
    PerformanceView(onBack: {}, onRetry: {}, onDone: {})
}
