//
//  NetworkService.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import Foundation

class NetworkService: ObservableObject {
    
    // MARK: - Nested Types
    
    enum NewsType {
        case frontPage
        case stories
    }
    
    // MARK: - Properties
    
    @Published var news: [News] = []
    @Published var stories: [News] = []
    
    // MARK: - Public
    
    func fetchDataFromFrontPageAndStories() {
        fetchDataFromFrontPage()
        fetchStories()
    }
}

// MARK: - Private

private extension NetworkService {
    func fetchDataFromFrontPage() {
        fetchNews(using: "http://hn.algolia.com/api/v1/search?tags=front_page", andNewsType: .frontPage)
    }
    
    func fetchStories() {
        fetchNews(using: "https://hn.algolia.com/api/v1/search_by_date?tags=story", andNewsType: .stories)
    }
        
    func fetchNews(using urlString: String, andNewsType newsType: NewsType) {
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
                        
                        let hits = results.hits
                        
                        switch newsType {
                        case .frontPage:
                            self.news = hits
                        case .stories:
                            self.stories = hits
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        task.resume()
    }
}
