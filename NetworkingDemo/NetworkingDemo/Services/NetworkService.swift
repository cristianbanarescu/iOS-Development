//
//  NetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    var baseURLString: String { get }
    func fetchPosts() -> [Post]
    func deletePosts()
    func createPost()
    func updatePost() -> Post
}

extension NetworkServiceProtocol {
    var baseURLString: String {
        "https://jsonplaceholder.typicode.com"
    }
}
