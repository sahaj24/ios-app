import SwiftUI

/// Thin horizontal line. Soft by default; pass `.swDivider` for a brighter one.
struct SpeakwellDivider: View {
    var color: Color = .swBorder

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: Constants.Size.hairline)
    }
}

#Preview {
    SpeakwellDivider()
        .padding()
        .screenBackground()
}
