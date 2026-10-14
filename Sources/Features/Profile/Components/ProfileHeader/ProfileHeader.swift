import SwiftUI

/// Avatar circle and the user's name.
struct ProfileHeader: View {
    let name: String

    var body: some View {
        HStack(spacing: Spacing.s12) {
            Image(systemName: "person.crop.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.swInk, Color.swLavender)
                .font(.system(size: Constants.Size.avatar))
            Text(name)
                .font(.swTitle3)
                .foregroundColor(.swText)
        }
    }
}

#Preview {
    ProfileHeader(name: "Abhinav")
        .padding()
        .screenBackground()
}
