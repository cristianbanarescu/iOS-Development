//
//  AlamofireNetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation

struct AlamofireNetworkService: NetworkServiceProtocol {
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        completion([])
    }
    
    func deletePosts() {
        
    }
    
    func createPost() {
        
    }
    
    func updatePost(completion: @escaping (Post?) -> Void) {
        completion(nil)
    }
}
