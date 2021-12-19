import Foundation

extension String {
  func convertDateFormat() -> String {
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let oldDate = olDateFormatter.date(from: self)
    guard let date = oldDate else {
      return "Invalid Date Format"
    }
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
    return convertDateFormatter.string(from: date)
  }
}

extension NSObject {
    
    static var ClassName: String {
        return String(describing: self)
    }
}
