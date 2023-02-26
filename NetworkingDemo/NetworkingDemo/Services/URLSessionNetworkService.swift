//
//  URLSessionNetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation

struct URLSessionNetworkService: NetworkServiceProtocol {
    
    // MARK: - Nested types
    
    enum HTTPMethod: String {
        case get
        case delete
        case put
        case post
    }
    
    // MARK: - Properties
    
    private let dispatchQueue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    // MARK: - Public
    
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        guard let urlRequest = urlRequest(with: "\(baseURLString)", httpMethod: .get) else {
            completion([])
            return
        }
        
        dispatchQueue.async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                handleError(error, requestHTTPMethod: urlRequest.httpMethod)
                handleResponse(response: response)
                
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
        guard let urlRequest = urlRequest(with: "\(baseURLString)/1", httpMethod: .delete) else {
            return
        }
        
        dispatchQueue.async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                handleError(error, requestHTTPMethod: urlRequest.httpMethod)
                handleResponse(response: response)
            }
            dataTask.resume()
        }
    }
    
    func createPost() {
        guard var urlRequest = urlRequest(with: "\(baseURLString)", httpMethod: .post) else {
            return
        }
                
        let post = Post(userId: 1, id: 1, title: "foo", body: "bar")
        
        do {
            let data = try JSONEncoder().encode(post)
            urlRequest.httpBody = data
        } catch {
            print("Could not encode post object into Data")
        }
        
        dispatchQueue.async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                handleError(error, requestHTTPMethod: urlRequest.httpMethod)
                handleResponse(response: response)
                
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
        guard var urlRequest = urlRequest(with: "\(baseURLString)/1", httpMethod: .put) else {
            return
        }
                
        let post = Post(userId: 1, id: 1, title: "foo", body: "bar")
        
        do {
            let data = try JSONEncoder().encode(post)
            urlRequest.httpBody = data
        } catch {
            print("Could not encode post object into Data")
        }
        
        dispatchQueue.async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                handleError(error, requestHTTPMethod: urlRequest.httpMethod)
                handleResponse(response: response)
                
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
    func urlRequest(with urlString: String, httpMethod: URLSessionNetworkService.HTTPMethod) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue.capitalized
        
        return urlRequest
    }
    
    func handleError(_ error: Error?, requestHTTPMethod httpMethod: String?) {
        if let error = error {
            print("Couldn't perform \(httpMethod ?? "unknown http method") request. Error: \(error.localizedDescription)")
        }
    }
    
    func handleResponse(response: URLResponse?) {
        if let response = response as? HTTPURLResponse {
            print("Got response with status code: \(response.statusCode)")
        }
    }
}
