//
//  StockViewModel.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 30.07.2024.
//

import Foundation

struct StockViewModel {
    
    private let stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    var symbol: String {
        stock.symbol.uppercased()
    }
    
    var price: String {
        String(format: "%.2f", stock.price)
    }
    
    var description: String {
        stock.description
    }
    
    var change: String {
        stock.change
    }
}
