import SwiftUI

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    
    private var cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(UIImage?) -> Void]]()
    
    func load(url: NSURL, completion: @escaping (UIImage?) -> Void) {
        //TEST: see if it's cached
//        if let cachedImage = cachedImages.object(forKey: url) {
//            print("Cache hit for: \(url)")
//            completion(cachedImage)
//            return
//        } else {
//            print("Cache miss for: \(url)")
//        }
        
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        
        URLSession.shared.dataTask(with: url as URL) { data, _, _ in
            var image: UIImage? = nil
            if let data = data {
                image = UIImage(data: data)
                if let img = image {
                    self.cachedImages.setObject(img, forKey: url, cost: data.count)
                }
            }
            
            if let completions = self.loadingResponses[url] {
                DispatchQueue.main.async {
                    completions.forEach { $0(image) }
                }
                self.loadingResponses.removeValue(forKey: url)
            }
        }.resume()
    }
}
