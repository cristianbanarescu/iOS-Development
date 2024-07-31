//
//  StockListView.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 31.07.2024.
//

import SwiftUI

struct StockListView: View {
    let stocks: [StockViewModel]
    
    var body: some View {
        List(stocks, id: \.symbol) { stock in
            HStack {
                VStack(alignment: .leading) {
                    Text(stock.symbol)
                        .bold()
                        .foregroundStyle(.primary)
                    Text(stock.description)
                        .foregroundStyle(.gray)
                }
                .font(.system(size: 20))
                .listRowBackground(Color.secondary)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("$\(stock.price)")
                    Text(stock.change)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 6).foregroundStyle(.red))
                }
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Stocks")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    StockListView(stocks: [StockViewModel(stock: Stock(symbol: "abd", description: "qweqw", price: 100, change: "-12"))])
}
