//
//  StockListViewModel.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 30.07.2024.
//

import Foundation

class StockListViewModel: ObservableObject {
    @Published var stocks: [StockViewModel] = []
    @Published var searchTerm: String = ""
    
    func fetchStocks() {
        Task {
            let stocks = await WebService().fetchStocks()
            
            await MainActor.run {
                self.stocks = stocks.map { StockViewModel(stock: $0) }
            }
        }
    }
}
