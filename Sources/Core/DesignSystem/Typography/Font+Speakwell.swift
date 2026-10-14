import SwiftUI

/// Type styles. Views use these names, never raw point sizes.
extension Font {
    static let swLargeTitle = Font.system(size: 28, weight: .bold)
    static let swTitle = Font.system(size: 28, weight: .bold)
    static let swTitle2 = Font.system(size: 22, weight: .bold)
    static let swTitle3 = Font.system(size: 20, weight: .bold)
    static let swHeadline = Font.system(size: 17, weight: .semibold)
    static let swBody = Font.system(size: 16, weight: .regular)
    static let swCallout = Font.system(size: 16, weight: .regular)
    static let swSubheadline = Font.system(size: 15, weight: .regular)
    static let swSubheadlineSemibold = Font.system(size: 15, weight: .semibold)
    static let swFootnote = Font.system(size: 13, weight: .regular)
    static let swFootnoteSemibold = Font.system(size: 13, weight: .semibold)
    static let swCaption = Font.system(size: 12, weight: .medium)
    static let swTabLabel = Font.system(size: 11, weight: .semibold)
    static let swScoreDisplay = Font.system(size: 110, weight: .light)
    static let swRingValue = Font.system(size: 24, weight: .bold)
    static let swStat = Font.system(size: 28, weight: .bold)
    static let swTimer = Font.system(size: 28, weight: .light)
    static let swCountdown = Font.system(size: 26, weight: .bold)
    static let swStreakDisplay = Font.system(size: 36, weight: .semibold)
    static let swMetric = Font.system(size: 24, weight: .semibold)
}
