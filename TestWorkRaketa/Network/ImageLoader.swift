//
//  ImageLoader.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    var imageCach = NSCache<NSString, UIImage>()
    
    func loadImage(url: URL, completion: @escaping (UIImage?)->Void) {
        
        if let cachedImage = imageCach.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                
                guard error == nil,
                    data != nil,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                    completion(nil)
                    return
                }
                
                guard let image = UIImage(data: data!) else {
                    completion(nil)
                    return
                }
                self?.imageCach.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }
            dataTask.resume()
        }
    }
    
    
    func removeCatch(key: String) {
        self.imageCach.removeObject(forKey: key as NSString)
    }
}
