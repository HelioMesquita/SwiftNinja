import Foundation

class APIDateFormatter {
  static func defaultNumberFormatter(value: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS+hh:mm"

    let date = dateFormatter.date(from: value)!

    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "dd MMM"
    formatter.locale = Locale(identifier: "pt_BR")

    return formatter.string(from: date).uppercased()
  }
}
