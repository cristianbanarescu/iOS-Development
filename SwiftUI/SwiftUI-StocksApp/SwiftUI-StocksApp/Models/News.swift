//
//  News.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 30.07.2024.
//

import Foundation

struct News: Decodable {
    let title: String
    let publication: String
    let imageURL: URL
}

