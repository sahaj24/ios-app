import Foundation

struct SkillScore: Identifiable, Equatable {
    let name: String
    let value: Int

    var id: String { name }

    /// 92 -> 0.92, used by the progress rings.
    var fraction: Double { Double(value) / 100 }
}
