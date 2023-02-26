//
//  NetworkService.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 26.02.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchPosts() -> [Post]
    func deletePosts()
    func createPost()
    func updatePost() -> Post
}
