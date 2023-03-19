//
//  Results.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import Foundation

struct Results: Decodable {
    let hits: [News]
}

struct News: Decodable, Identifiable {
    
    // MARK: - Nested Types
    
    enum CodingKeys: String, CodingKey {
        case objectID
        case title
        case url
        case numberOfComments = "num_comments"
    }
    
    // MARK: - Properties
    
    var id: String {
        objectID
    }
    
    let objectID: String
    let title: String
    let numberOfComments: Int
    let url: String?
}
