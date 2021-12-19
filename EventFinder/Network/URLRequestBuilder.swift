import Foundation

struct URLRequestBuilder {
  
  struct Constant {
    static let baseURL = "https://api.seatgeek.com/2/?=MjI3NTkyMzV8MTYyNzkzNTM2OS41MzUwMTc"
    static let path = "/2/events/"
    static let clinetID = "client_id"
    static let apiKey = "MjI3NTkyMzV8MTYyNzkzNTM2OS41MzUwMTc"
  }
  
  let defaultHttpMethod = "get"

  func searchURL(queryString: String) -> URLRequest {
    var urlComponent = URLComponents(string: Constant.baseURL)
    urlComponent?.path = Constant.path
    let searchItem = URLQueryItem(name: "q", value: queryString)
    let defaultItem = URLQueryItem(name: Constant.clinetID, value: Constant.apiKey)
    urlComponent?.queryItems = [searchItem, defaultItem]
    var urlRequest = URLRequest(url: (urlComponent?.url!)!)
    urlRequest.httpMethod = defaultHttpMethod
    return urlRequest
  }
}
