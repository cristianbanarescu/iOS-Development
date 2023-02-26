//
//  AlamofireNetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation

struct AlamofireNetworkService: NetworkServiceProtocol {
    func fetchPosts() -> [Post] {
        []
    }
    
    func deletePosts() {
        
    }
    
    func createPost() {
        
    }
    
    func updatePost() -> Post {
        Post(userId: 1, id: 1, title: "", body: "")
    }
}
