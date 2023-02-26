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
                    print("Couldn't perform \(urlRequest.httpMethod ?? "unknown http method") request. Error: \(error.localizedDescription)")
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
                    print("Couldn't perform \(urlRequest.httpMethod ?? "unknown http method") request. Error: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response with status code: \(response.statusCode)")
                }
            }
            dataTask.resume()
        }
    }
    
    func createPost() {
        guard var urlRequest = urlRequest(with: "\(baseURLString)", httpMethod: "POST") else {
            return
        }
                
        let post = Post(userId: 1, id: 1, title: "foo", body: "bar")
        
        do {
            let data = try JSONEncoder().encode(post)
            
            urlRequest.httpBody = data
        } catch {
            print("Could not encode post object into Data")
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Couldn't perform \(urlRequest.httpMethod ?? "unknown http method") request. Error: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response with status code: \(response.statusCode)")
                }
                
                if let data = data {
                    do {
                        let createdPostDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                        print("Creating new Post object is OK. The new id is: \(createdPostDictionary["id"] ?? "")")
                    } catch {
                        print("Could not decode created post. Error: \(error.localizedDescription)")
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func updatePost(completion: @escaping (Post?) -> Void) {
        guard var urlRequest = urlRequest(with: "\(baseURLString)/1", httpMethod: "PUT") else {
            return
        }
                
        let post = Post(userId: 1, id: 1, title: "foo", body: "bar")
        
        do {
            let data = try JSONEncoder().encode(post)
            
            urlRequest.httpBody = data
        } catch {
            print("Could not encode post object into Data")
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Couldn't perform \(urlRequest.httpMethod ?? "unknown http method") request. Error: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response with status code: \(response.statusCode)")
                }
                
                if let data = data {
                    do {
                        let createdPostDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                        print("Updating the Post object is OK. The new id is: \(createdPostDictionary["id"] ?? "")")
                        completion(post)
                    } catch {
                        print("Could not decode updated post. Error: \(error.localizedDescription)")
                    }
                }
            }
            dataTask.resume()
        }
        completion(nil)
    }
}

// MARK: - Private

private extension URLSessionNetworkService {
    func urlRequest(with urlString: String, httpMethod: String? = nil) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        return urlRequest
    }
}
