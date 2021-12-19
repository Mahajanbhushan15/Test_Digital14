import Foundation
import UIKit

protocol CloudManager {
  var config: URLSession { get }
  func callAPI<T: Codable>(request: URLRequest, completion: @escaping (Result<T,APIError>)->Void)
  func loadImage(url: URL, completion: @escaping (Result<UIImage,APIError>)->Void)
}

extension CloudManager {

  func callAPI<T: Codable>(request: URLRequest, completion: @escaping (Result<T,APIError>)->Void) {
    config.dataTask(with: request) { (data, response, error) in
      guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
        return completion(.failure(APIError.urlError))
      }
      guard let apiData = data else {
        return completion(.failure(APIError.noData))
      }
      guard let dataObj = try? JSONDecoder().decode(T.self, from: apiData) else {
        return completion(.failure(APIError.parsingFailed))
      }
      return completion(.success(dataObj))
    }.resume()
  }
  
  func loadImage(url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void) {
    config.dataTask(with: url) { (data, response, err) in
      guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
        return completion(.failure(APIError.urlError))
      }
      guard let apiData = data, let image = UIImage(data: apiData) else {
        return completion(.failure(APIError.noData))
      }
      return completion(.success(image))
    }.resume()
  }
}
