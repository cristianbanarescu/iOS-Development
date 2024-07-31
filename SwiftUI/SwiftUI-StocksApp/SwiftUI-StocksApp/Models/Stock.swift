//
//  Stock.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 30.07.2024.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let description: String
    let price: Double
    let change: String
}
