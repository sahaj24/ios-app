import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.semibold)

            Text(viewModel.message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
