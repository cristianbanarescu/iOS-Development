//
//  NetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    var baseURLString: String { get }
    func fetchPosts(completion: @escaping ([Post]) -> Void)
    func deletePosts()
    func createPost()
    func updatePost(completion: @escaping (Post?) -> Void)
}

extension NetworkServiceProtocol {
    var baseURLString: String {
        "https://jsonplaceholder.typicode.com/posts"
    }
}
