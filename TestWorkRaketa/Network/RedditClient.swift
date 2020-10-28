//
//  RedditClient.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//
import UIKit

// Нужно поработать над обработкой ошибок в данном запросе

enum APIRoute {
    static let topListingUrl = "https://www.reddit.com/top.json?limit=15"
}

class RedditClient {
    static let shared = RedditClient()
    
    func getTopData(afterID: String?, completion: @escaping ([ChildData], Error?) -> Void)  {
        
        var urlString: String = APIRoute.topListingUrl
        
        if let _afterID = afterID {
            urlString.append("&after="+_afterID)
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(RedditModel.self, from: data)
                
                let topEntries = response.data.children.map({ $0.data })
                
                completion(topEntries, nil)
                
            } catch let jsonError {
                completion([], jsonError)
                print(jsonError)
            }
            
            }.resume()
    }
}
