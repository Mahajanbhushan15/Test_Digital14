import Foundation
import UIKit

class CloudManagerImpl: CloudManager {
  var config: URLSession
  
  init(config: URLSessionConfiguration) {
    let urlSession = URLSession(configuration: config)
    self.config = urlSession
  }
  
  convenience init() {
    self.init(config: .default)
  }
}

