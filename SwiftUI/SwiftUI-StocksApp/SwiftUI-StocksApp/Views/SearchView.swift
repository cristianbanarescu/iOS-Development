//
//  SearchView.swift
//  SwiftUI-StocksApp
//
//  Created by Cristian Banarescu on 30.07.2024.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)
            
            TextField(text: $searchText) {
                Text("Search")
                    .foregroundStyle(.white)
                    
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.secondary))
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
