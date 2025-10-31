//
//  CombineDemo.swift
//  CombineiOSApp
//
//  Created by Cristian Banarescu on 31.10.2025.
//

import Combine
import UIKit

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    
    static let `default` = User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@example.com")
}
