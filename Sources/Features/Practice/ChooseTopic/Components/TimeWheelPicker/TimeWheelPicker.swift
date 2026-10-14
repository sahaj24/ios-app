import SwiftUI

/// One native wheel (minutes or seconds) with its unit label next to the selected value.
struct TimeWheelPicker: View {
    @Binding var selection: Int
    let values: [Int]
    let unit: String
    /// Show 5 as "05" (used for seconds).
    let padsDigits: Bool

    var body: some View {
        Picker(unit, selection: $selection) {
            ForEach(values, id: \.self) { value in
                Text(padsDigits ? String(format: "%02d", value) : "\(value)")
                    .font(.swHeadline)
                    .foregroundColor(.swText)
                    .tag(value)
            }
        }
        .pickerStyle(.wheel)
        .frame(height: Constants.Size.timeWheelHeight)
        .overlay(alignment: .trailing) {
            Text(unit)
                .font(.swBody)
                .foregroundColor(.swText)
                .padding(.trailing, Constants.Size.timeWheelUnitInset)
                .allowsHitTesting(false)
        }
        .compositingGroup()
        .clipped()
    }
}

#Preview {
    TimeWheelPicker(selection: .constant(2), values: Array(2...10), unit: "min", padsDigits: false)
        .padding()
        .screenBackground()
}
