import Foundation

final class DisplayAccessibilityViewModel: ObservableObject {
    /// 0...4, where 2 is the default size. Mock only (no live text scaling yet).
    @Published var textSize: Double = 2
    @Published var reduceMotion = false
    @Published var reduceTransparency = false

    var textSizeLabel: String {
        switch Int(textSize.rounded()) {
        case 0: return "Small"
        case 1: return "Medium"
        case 2: return "Default"
        case 3: return "Large"
        default: return "Extra Large"
        }
    }
}
