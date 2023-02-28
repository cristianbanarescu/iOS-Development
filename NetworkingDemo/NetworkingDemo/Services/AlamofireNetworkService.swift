//
//  AlamofireNetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation
import Alamofire

// TODO refactor to remove code duplication

struct AlamofireNetworkService: NetworkServiceProtocol {
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        let request = AF.request(baseURLString)
        
        let dataResponseCompletionHandler: (DataResponse<[Post], AFError>) -> Void = { response in
            let result = response.result
            
            switch result {
            case .success(let posts):
                completion(posts)
            case .failure(let error):
                handle(error: error, for: "GET")
            }
        }
        
        request
            .validate()
            .responseDecodable(completionHandler: dataResponseCompletionHandler)
    }
    
    func deletePosts() {
        let request = AF.request("\(baseURLString)/1", method: .delete)
        
        request
            .validate()
            .response { response in
                let result = response.result
                
                switch result {
                case .success(_):
                    print("Performing Alamofire DELETE request was OK")
                case .failure(let error):
                    handle(error: error, for: "DELETE")
                }
            }
    }
    
    func createPost() {
        guard let url = URL(string: baseURLString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let post = Post(userId: 1, id: 1, title: "foo", body: "bar")
        
        do {
            let data = try JSONEncoder().encode(post)
            request.httpBody = data
        } catch {
            print("Could not encode post object into Data")
        }
        
        AF
            .request(request)
            .validate()
            .response { response in
                let result = response.result
                
                switch result {
                case .success(let postData):
                    do {
                        let createdPostDictionary = try JSONSerialization.jsonObject(with: postData ?? Data()) as? [String: Any] ?? [:]
                        print("Creating new Post object is OK. The new id is: \(createdPostDictionary["id"] ?? "")")
                    } catch {
                        print("Could not decode created post. Error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    handle(error: error, for: "POST")
                }
            }
    }
    
    func updatePost(completion: @escaping (Post?) -> Void) {
        guard let url = URL(string: "\(baseURLString)/1") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let post = Post(userId: 1, id: 1, title: "foo", body: "bar")
        
        do {
            let data = try JSONEncoder().encode(post)
            request.httpBody = data
        } catch {
            print("Could not encode post object into Data")
        }
        
        AF
            .request(request)
            .validate()
            .response { response in
                let result = response.result
                
                switch result {
                case .success(let postData):
                    do {
                        let createdPostDictionary = try JSONSerialization.jsonObject(with: postData ?? Data()) as? [String: Any] ?? [:]
                        print("Updating new Post object is OK. The new id is: \(createdPostDictionary["id"] ?? "")")
                    } catch {
                        print("Could not decode updated post. Error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    handle(error: error, for: "PUT")
                }
            }
    }
}

// MARK: - Private

private extension AlamofireNetworkService {
    func handle(error: AFError, for requestTypeString: String) {
        print("Performing Alamofire \(requestTypeString) request for Post ojects failed with error: \(error.localizedDescription)")
    }
}
