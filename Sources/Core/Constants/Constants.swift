import CoreGraphics
import Foundation

/// App-wide constants. Add values here instead of hardcoding
/// strings/numbers across the codebase.
enum Constants {
    enum App {
        static let name = "Speakwell"
    }

    enum Session {
        static let secondsPerMinute = 60
        static let defaultSeconds = 120

        /// Limits for custom times (seconds).
        static let prepRange = 120...600
        static let speakRange = 30...900

        /// Menu presets (seconds).
        static let prepPresets = [120, 180, 300, 600]
        static let speakPresets = [60, 120, 180, 300]
    }

    enum Size {
        static let hairline: CGFloat = 1
        static let glassButton: CGFloat = 44
        static let primaryButton: CGFloat = 54
        static let segmented: CGFloat = 42
        static let segmentedInset: CGFloat = 3
        static let chipHeight: CGFloat = 62
        static let recordButton: CGFloat = 96
        static let countdownRing: CGFloat = 96
        static let countdownLine: CGFloat = 3
        static let tabBarHeight: CGFloat = 60
        static let tabBarInset: CGFloat = 50
        static let tabBarBottomGap: CGFloat = 22
        static let tabBarClearance: CGFloat = 101
        static let tabItemWidth: CGFloat = 104
        static let iconCircle: CGFloat = 34
        static let avatar: CGFloat = 48
        static let ringChart: CGFloat = 148
        static let ringLine: CGFloat = 14
        static let ringGap: CGFloat = 4
        static let legendDot: CGFloat = 6
        /// Room for two lines of the topic title.
        static let topicTextHeight: CGFloat = 56
        /// Fixed inner height of the topic card (header + text + pick button),
        /// so it is identical in "Random topic" and "My own topic".
        static let topicCardContentHeight: CGFloat = glassButton * 2 + topicTextHeight + 24
        static let chevron: CGFloat = 13
        static let editorHeight: CGFloat = 120
        /// Key points sheet: header + editor + save button + paddings.
        static let outlineSheetHeight: CGFloat = 300
        static let streakStatLine: CGFloat = 44
        static let streakLongestColumn: CGFloat = 116
        static let streakWeekHeight: CGFloat = 89
        static let streakDayCircle: CGFloat = 36
        static let streakDayLabelHeight: CGFloat = 16
        static let streakDayLabelGap: CGFloat = 7
        static let streakDot: CGFloat = 7
        static let streakDotGap: CGFloat = 10
        static let streakPageTargetWidth: CGFloat = 64
        static let streakPageTargetHeight: CGFloat = 44
        static let streakTotalRow: CGFloat = 40
        static let milestoneBadge: CGFloat = 68
        static let milestoneSeal: CGFloat = 52
        static let customSheetHeight: CGFloat = 440
        static let timeWheelHeight: CGFloat = 216
        static let laurelSymbol: CGFloat = 72
    }
}
