import Foundation

class HomeViewModel {
    let cloudManager: CloudManagerImpl
    
    init(cloudManager: CloudManagerImpl) {
        self.cloudManager = cloudManager
    }
    
    func callSearchAPI(text: String, completion: @escaping (Result<EventMetadata, APIError>) -> Void) {
        let searchUrl = URLRequestBuilder().searchURL(queryString: text)
        return cloudManager.callAPI(request: searchUrl) { (result) in
            completion(result)
        }
    }
    
//    func fetchFavoriteEventFromLocalStorage() -> [FavoriteEvent]? {
//        return manager.fetchAllFavoriteEvent()
//    }
}
