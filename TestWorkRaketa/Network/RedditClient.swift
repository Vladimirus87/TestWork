//
//  RedditClient.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//
import UIKit

enum RedditClientError: Error {
    case parsingError
    case noConnection(string: String?)
}

class RedditClient {
    static let shared = RedditClient()
    
    var dataTasks : [URLSessionDataTask] = []
    
    func getTopData(afterID: String?, completion: @escaping ([ChildData], RedditClientError?) -> Void)  {
        
        var urlString: String = APIUrls.topUrl
        
        if let _afterID = afterID {
            urlString.append("&after="+_afterID)
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion([], .noConnection(string: error?.localizedDescription))
                return
            }

            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(RedditModel.self, from: data)
                
                let topEntries = response.data.children.map({ $0.data })
                
                completion(topEntries, nil)
                
            } catch let jsonError {
                completion([], .parsingError)
                print(jsonError)
            }
            
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
    
    
    func cancelDataTask(urlString: String) {
        guard let dataTaskIndex = dataTasks.firstIndex(where: { task in
            task.originalRequest?.url == URL(string: urlString)
        }) else {
            return
        }
        let dataTask =  dataTasks[dataTaskIndex]
        dataTask.cancel()
        dataTasks.remove(at: dataTaskIndex)
    }
}
