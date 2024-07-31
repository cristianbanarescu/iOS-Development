//
//  WebService.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 30.07.2024.
//

import Foundation

struct WebService {
    func fetchStocks() async -> [Stock] {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://island-bramble.glitch.me/stocks")!)
            let stocks = try JSONDecoder().decode([Stock].self, from: data)
            return stocks
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func fetchNews() async -> [News] {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://island-bramble.glitch.me/top-news")!)
            let news = try JSONDecoder().decode([News].self, from: data)
            return news
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
