//
//  NetworkService.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import Foundation

class NetworkService: ObservableObject {
    
    @Published var news: [News] = []
    
    func fetchData() {
        let urlString = "http://hn.algolia.com/api/v1/search?tags=front_page"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error)
            }
            
            if let data {
                let decoder = JSONDecoder()
                
                DispatchQueue.main.async {
                    do {
                        let results = try decoder.decode(Results.self, from: data)
                        self.news = results.hits
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        task.resume()
    }
}
