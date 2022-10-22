import Foundation

extension Date {
    static func minutes(startingFrom date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date, to: Date())
        return components.minute
    }
}
