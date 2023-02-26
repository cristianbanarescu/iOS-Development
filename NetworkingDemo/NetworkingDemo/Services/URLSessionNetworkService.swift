//
//  URLSessionNetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation

struct URLSessionNetworkService: NetworkServiceProtocol {
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        guard let urlRequest = urlRequest(with: "\(baseURLString)") else {
            completion([])
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Couldn't fetch data. Error: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response with status code: \(response.statusCode)")
                }
                
                if let data = data {
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: data)

                        completion(posts)                        
                    } catch {
                        print("Could not decode Post from data, error: \(error.localizedDescription)")
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func deletePosts() {
        guard let urlRequest = urlRequest(with: "\(baseURLString)/1", httpMethod: "DELETE") else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Couldn't perform delete request. Error: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response with status code: \(response.statusCode)")
                }
            }
            dataTask.resume()
        }
    }
    
    func createPost() {
        /*
         fetch('https://jsonplaceholder.typicode.com/posts', {
           method: 'POST',
           body: JSON.stringify({
             title: 'foo',
             body: 'bar',
             userId: 1,
           }),
           headers: {
             'Content-type': 'application/json; charset=UTF-8',
           },
         })
         */
    }
    
    func updatePost() -> Post {
        /*
         fetch('https://jsonplaceholder.typicode.com/posts/1', {
           method: 'PUT',
           body: JSON.stringify({
             id: 1,
             title: 'foo',
             body: 'bar',
             userId: 1,
           }),
           headers: {
             'Content-type': 'application/json; charset=UTF-8',
           },
         })
         */
        Post(userId: 1, id: 1, title: "", body: "")
    }
    
    func urlRequest(with urlString: String, httpMethod: String? = nil) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        return urlRequest
    }
}
