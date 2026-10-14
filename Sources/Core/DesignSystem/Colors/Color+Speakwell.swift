import SwiftUI

/// Every color used by the app. Hex values live ONLY in this file.
extension Color {
    // MARK: Background gradient (top glow fading to near black)
    static let swBackgroundTop = Color(hex: 0x29263A)
    static let swBackgroundGlow1 = Color(hex: 0x252233)
    static let swBackgroundGlow2 = Color(hex: 0x1E1C2A)
    static let swBackgroundGlow3 = Color(hex: 0x181621)
    static let swBackgroundMid = Color(hex: 0x101016)
    static let swBackground = Color(hex: 0x0D0D12)

    // MARK: Surfaces
    static let swSurface = Color(hex: 0x1C1C22)
    static let swSurfaceHighlight = Color(hex: 0x24242A)
    static let swRaised = Color(hex: 0x26262E)
    static let swSelected = Color(hex: 0x393940)
    static let swGlassButton = Color(hex: 0x333339)
    static let swSecondaryButton = Color(hex: 0x2A2931)
    static let swIconCircle = Color(hex: 0x2D293E)

    // MARK: Lines
    static let swBorder = Color.white.opacity(0.1)
    static let swDivider = Color(hex: 0xF5F5F7)

    // MARK: Text
    static let swText = Color(hex: 0xF5F5F7)
    static let swMuted = Color(hex: 0xAAAAB5)
    static let swInk = Color(hex: 0x181226)

    // MARK: Accent
    static let swAccent = Color(hex: 0xA190E0)
    static let swAccentHighlight = Color(hex: 0xC3B2F6)
    static let swLavender = Color(hex: 0xB6A3FF)
    static let swTabSelectedFill = Color(hex: 0xB6A3FF).opacity(0.25)

    // MARK: Score rings
    static let swRingTopic = Color(hex: 0xC8B9FF)
    static let swRingFluency = Color(hex: 0xE5DEED)
    static let swRingVocabulary = Color(hex: 0xB575E8)

    /// Ring/legend color for the skill at `index` (0 = outer ring).
    static func swSkill(at index: Int) -> Color {
        let colors: [Color] = [.swRingTopic, .swRingFluency, .swRingVocabulary]
        return colors[index % colors.count]
    }

    // MARK: Status
    static let swGreen = Color(hex: 0x68D9A4)
}
