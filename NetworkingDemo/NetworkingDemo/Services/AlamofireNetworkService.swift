//
//  AlamofireNetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation
import Alamofire

struct AlamofireNetworkService: NetworkServiceProtocol {
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        let request = AF.request(baseURLString)
        
        let dataResponseCompletionHandler: (DataResponse<[Post], AFError>) -> Void = { response in
            let result = response.result
            
            switch result {
            case .success(let posts):
                completion(posts)
            case .failure(let error):
                print("Performing Alamofire GET request for Post ojects failed with error: \(error.localizedDescription)")
            }
        }
        
        request
        .validate()
        .responseDecodable(completionHandler: dataResponseCompletionHandler)
    }
    
    func deletePosts() {
        
    }
    
    func createPost() {
        
    }
    
    func updatePost(completion: @escaping (Post?) -> Void) {
        completion(nil)
    }
}
