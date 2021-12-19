import Foundation

// Generic error enum which can be used to get Errors from web service
enum APIError: Error {
  case urlError, noData, parsingFailed
  
  public var description : String {
    switch self {
      case .urlError : return "URL error."
      case .noData: return "Data not found."
      case .parsingFailed: return "Unable to parse data from decoder."
    }
  }
}
