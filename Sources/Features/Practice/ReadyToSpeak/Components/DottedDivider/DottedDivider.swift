import SwiftUI

/// Faint dotted horizontal line above the timer.
struct DottedDivider: View {
    var body: some View {
        Line()
            .stroke(
                Color.swSelected,
                style: StrokeStyle(lineWidth: Constants.Size.hairline, dash: [Constants.Size.hairline, Spacing.s4])
            )
            .frame(height: Constants.Size.hairline)
            .padding(.horizontal, Spacing.s16)
    }
}

private struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

#Preview {
    DottedDivider()
        .padding()
        .screenBackground()
}
