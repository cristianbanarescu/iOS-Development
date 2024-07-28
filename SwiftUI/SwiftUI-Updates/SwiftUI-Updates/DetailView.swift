//
//  DetailView.swift
//  SwiftUI-Updates
//
//  Created by Cristian Banarescu on 28.07.2024.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: [
                    GridItem(.flexible(minimum: 50, maximum: 200)),
                    GridItem(.fixed(300)),
                    GridItem(.adaptive(minimum: 100, maximum: 200))
                ], spacing: 10) {
                    ForEach(Constants.sfSymbols, id: \.self) { sfSymbol in
                        Image(systemName: sfSymbol)
                            .resizable()
                            .scaledToFit()
                            .frame(width:  100, height: 100)
                    }
                }
                .navigationTitle("LazyHGrid")
            }
            .padding()
        }
    }
}

#Preview {
    DetailView()
}
