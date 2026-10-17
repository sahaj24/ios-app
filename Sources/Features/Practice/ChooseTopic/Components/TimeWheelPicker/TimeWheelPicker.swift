import SwiftUI
import UIKit

/// Apple Clock style time picker: one wheel for minutes, one for seconds,
/// a single selection bar across both, and the unit ("min", "sec") next to
/// the selected value.
struct TimeWheelPicker: View {
    @Binding var minutes: Int
    @Binding var seconds: Int
    let minuteValues: [Int]

    var body: some View {
        WheelPickerRepresentable(
            minutes: $minutes,
            seconds: $seconds,
            minuteValues: minuteValues,
            secondValues: Array(0..<Constants.Session.secondsPerMinute)
        )
        .frame(height: Constants.Size.timeWheelHeight)
    }
}

/// One wheel row: the number ends at the column center, the unit sits right after it.
/// The unit is only visible on the selected row.
private final class TimeWheelRowView: UIView {
    private let numberLabel = UILabel()
    private let unitLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberLabel.font = .monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .right
        unitLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        unitLabel.textColor = .white

        [numberLabel, unitLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            numberLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            unitLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 6),
            unitLabel.firstBaselineAnchor.constraint(equalTo: numberLabel.firstBaselineAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    func configure(number: String, unit: String, showsUnit: Bool) {
        numberLabel.text = number
        unitLabel.text = unit
        unitLabel.isHidden = !showsUnit
    }
}

/// UIPickerView with two components. Using one UIPickerView (not two SwiftUI
/// pickers) gives the single selection bar across both columns, like Clock.
private struct WheelPickerRepresentable: UIViewRepresentable {
    @Binding var minutes: Int
    @Binding var seconds: Int
    let minuteValues: [Int]
    let secondValues: [Int]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIView(_ picker: UIPickerView, context: Context) {
        context.coordinator.parent = self
        select(minutes, in: minuteValues, component: 0, picker: picker)
        select(seconds, in: secondValues, component: 1, picker: picker)
        context.coordinator.refreshUnits(in: picker)
    }

    private func select(_ value: Int, in values: [Int], component: Int, picker: UIPickerView) {
        guard let row = values.firstIndex(of: value), picker.selectedRow(inComponent: component) != row else { return }
        picker.selectRow(row, inComponent: component, animated: false)
    }

    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: WheelPickerRepresentable

        init(_ parent: WheelPickerRepresentable) {
            self.parent = parent
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int { 2 }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            values(for: component).count
        }

        func pickerView(
            _ pickerView: UIPickerView,
            viewForRow row: Int,
            forComponent component: Int,
            reusing view: UIView?
        ) -> UIView {
            let rowView = (view as? TimeWheelRowView) ?? TimeWheelRowView()
            let value = values(for: component)[row]
            rowView.configure(
                number: component == 1 ? String(format: "%02d", value) : "\(value)",
                unit: unit(for: component),
                showsUnit: row == pickerView.selectedRow(inComponent: component)
            )
            return rowView
        }

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 36 }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let value = values(for: component)[row]
            if component == 0 {
                parent.minutes = value
            } else {
                parent.seconds = value
            }
            refreshUnits(in: pickerView)
        }

        /// Shows the unit only on the selected row of each wheel.
        func refreshUnits(in picker: UIPickerView) {
            for component in 0..<2 {
                let selected = picker.selectedRow(inComponent: component)
                let count = values(for: component).count
                for row in max(selected - 3, 0)...min(selected + 3, count - 1) {
                    guard let rowView = picker.view(forRow: row, forComponent: component) as? TimeWheelRowView else { continue }
                    let value = values(for: component)[row]
                    rowView.configure(
                        number: component == 1 ? String(format: "%02d", value) : "\(value)",
                        unit: unit(for: component),
                        showsUnit: row == selected
                    )
                }
            }
        }

        private func values(for component: Int) -> [Int] {
            component == 0 ? parent.minuteValues : parent.secondValues
        }

        private func unit(for component: Int) -> String {
            component == 0 ? "min" : "sec"
        }
    }
}

#Preview {
    TimeWheelPicker(minutes: .constant(2), seconds: .constant(0), minuteValues: Array(2...10))
        .padding()
        .screenBackground()
}
