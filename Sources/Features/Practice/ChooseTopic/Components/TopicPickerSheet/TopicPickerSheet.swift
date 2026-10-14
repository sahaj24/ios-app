import SwiftUI

/// Sheet for choosing a topic by hand or asking for a random one.
/// Top level: search plus the 20 categories. Inside a category: its 100 topics.
/// The bottom button draws a random topic from the open category (or all topics).
struct TopicPickerSheet: View {
    @StateObject private var viewModel = TopicPickerViewModel()
    let onPick: (Topic) -> Void
    let onRandom: (TopicCategory?) -> Void
    let onClose: () -> Void

    var body: some View {
        VStack(spacing: Spacing.s16) {
            header
            SearchField(text: $viewModel.searchText, placeholder: viewModel.searchPlaceholder)
            list
            PrimaryButton(title: viewModel.randomButtonTitle) {
                onRandom(viewModel.selectedCategory)
            }
        }
        .padding(.horizontal, Spacing.s24)
        .padding(.top, Spacing.s24)
        .padding(.bottom, Spacing.s12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.swSurface.ignoresSafeArea())
    }

    private var header: some View {
        HStack(spacing: Spacing.s12) {
            if viewModel.selectedCategory != nil {
                GlassCircleButton(systemName: "chevron.left", action: viewModel.back)
                    .accessibilityLabel("Back to categories")
            }
            Text(viewModel.title)
                .font(.swTitle2)
                .foregroundColor(.swText)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            Spacer(minLength: 0)
            GlassCircleButton(systemName: "xmark", action: onClose)
                .accessibilityLabel("Close")
        }
    }

    @ViewBuilder
    private var list: some View {
        if viewModel.isSearching {
            topicList(viewModel.searchResults, emptyText: "No topics match your search.")
        } else if viewModel.selectedCategory != nil {
            topicList(viewModel.categoryTopics, emptyText: "")
        } else {
            categoryList
        }
    }

    private var categoryList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.categories) { category in
                    TopicPickerRow(
                        title: category.title,
                        detail: viewModel.countText(for: category),
                        showsChevron: true
                    ) {
                        viewModel.open(category)
                    }
                }
            }
        }
    }

    private func topicList(_ topics: [Topic], emptyText: String) -> some View {
        ScrollView(showsIndicators: false) {
            if topics.isEmpty {
                Text(emptyText)
                    .font(.swBody)
                    .foregroundColor(.swMuted)
                    .frame(maxWidth: .infinity)
                    .padding(.top, Spacing.s32)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(topics) { topic in
                        TopicPickerRow(title: topic.title) { onPick(topic) }
                    }
                }
            }
        }
    }
}

#Preview {
    TopicPickerSheet(onPick: { _ in }, onRandom: { _ in }, onClose: {})
}
