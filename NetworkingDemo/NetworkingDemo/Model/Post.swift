//
//  Post.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 25.02.2023.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
