import UIKit
import Foundation

final class CustomImageView: UIImageView, CloudManager {

  var config: URLSession {
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .returnCacheDataElseLoad
    config.urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024,
                               diskCapacity: 20 * 1024 * 1024,
                               diskPath: nil)
    return URLSession(configuration: config)
  }

  
  let imageCache = NSCache<NSString,AnyObject>()
  var imageURLString: String?
  
  func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode = .redraw) {
      guard let url = URL(string: urlString) else { return }
      downloadImageFrom(url: url, imageMode: imageMode)
  }

  private func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
      contentMode = imageMode
      if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
          self.image = cachedImage
      } else {
        loadImage(url: url) { result in
          if case .success(let image) = result {
            DispatchQueue.main.async {
              self.image = image
              self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            }
          }
        }
      }
  }
}
