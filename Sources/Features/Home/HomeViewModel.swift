import Foundation

/// Simple view model for HomeView.
/// Keep view models small: hold view state, no business logic beyond
/// what the view needs to render.
final class HomeViewModel: ObservableObject {
    @Published var title: String = "MyApp"
    @Published var message: String = "Boilerplate is ready. Start building here."
}
