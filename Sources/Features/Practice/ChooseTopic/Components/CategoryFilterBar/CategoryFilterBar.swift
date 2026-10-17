import SwiftUI

/// Horizontal filter chips: "All" plus one chip per topic category.
/// Picking a category limits the list to that category's subtopics.
struct CategoryFilterBar: View {
    let categories: [TopicCategory]
    let selected: TopicCategory?
    let onSelect: (TopicCategory?) -> Void

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.s8) {
                    chip(title: "All", isSelected: selected == nil) { onSelect(nil) }
                        .id("all")
                    ForEach(categories) { category in
                        chip(title: category.title, isSelected: category.id == selected?.id) {
                            onSelect(category)
                        }
                        .id(category.id)
                    }
                }
            }
            .onChange(of: selected?.id) { id in
                withAnimation { proxy.scrollTo(id ?? "all", anchor: .center) }
            }
        }
    }

    private func chip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.swSubheadlineSemibold)
                .foregroundColor(isSelected ? .swBackground : .swText)
                .padding(.horizontal, Spacing.s16)
                .frame(height: Constants.Size.segmented)
                .background(isSelected ? Color.swLavender : Color.swRaised.opacity(0.7), in: Capsule())
                .overlay(Capsule().strokeBorder(Color.swBorder, lineWidth: isSelected ? 0 : Constants.Size.hairline))
        }
        .buttonStyle(.speakwellPressable)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    CategoryFilterBar(categories: TopicProvider.categories, selected: nil, onSelect: { _ in })
        .padding()
        .screenBackground()
}
