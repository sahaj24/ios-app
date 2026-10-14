import Foundation

/// Anything that can be shown as a segment: an enum with a title.
protocol SegmentOption: CaseIterable, Hashable {
    var title: String { get }
}
