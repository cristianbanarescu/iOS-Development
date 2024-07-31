//
//  ContentView.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 30.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var stockListVM = StockListViewModel()
    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        let filteredStocks = stockListVM.searchTerm.isEmpty ? stockListVM.stocks : stockListVM.stocks.filter { $0.symbol.lowercased().contains(stockListVM.searchTerm.lowercased()) || $0.description.lowercased().contains(stockListVM.searchTerm.lowercased()) }
        
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text(formattedDate)
                        .font(.system(size: 25))
                        .foregroundStyle(.gray)
                        .bold()
                        .padding(.leading)
                    
                    SearchView(searchText: $stockListVM.searchTerm)
                    
                    StockListView(stocks: filteredStocks)
                        .listRowBackground(Color.clear)
                }
            }
            .onAppear {
                stockListVM.fetchStocks()
            }
        }
    }
}

#Preview {
    ContentView()
}
