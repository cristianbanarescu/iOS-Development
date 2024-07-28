//
//  ContentView.swift
//  SwiftUI-Updates
//
//  Created by Cristian Banarescu on 14.07.2024.
//

import SwiftUI

struct Constants {
    static let sfSymbols: [String] = [
        "house", "house.fill", "gear", "gearshape", "gearshape.fill", "gearshape.2", "gearshape.2.fill", "person",
        "person.fill", "person.2", "person.2.fill", "person.3", "person.3.fill", "person.crop.circle",
        "person.crop.circle.fill", "person.crop.square", "person.crop.square.fill", "book", "book.fill", "books.vertical",
        "books.vertical.fill", "calendar", "calendar.badge.plus", "calendar.badge.minus", "camera", "camera.fill",
        "camera.circle", "camera.circle.fill", "cart", "cart.fill", "car", "car.fill", "airplane", "airplane.circle",
        "airplane.circle.fill", "bicycle", "bus", "bus.fill", "tram", "tram.fill", "heart", "heart.fill", "heart.circle",
        "heart.circle.fill", "star", "star.fill", "star.circle", "star.circle.fill", "moon", "moon.fill", "moon.stars",
        "hammer.fill", "paintbrush", "paintbrush.fill", "scissors", "scissors.badge.ellipsis"
    ]
}

struct ContentView: View {    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    let columnWidth = proxy.size.width / 3
                    
                    let gridColumns: [GridItem] = [
                        GridItem(.fixed(columnWidth)),
                        GridItem(.fixed(columnWidth)),
                        GridItem(.fixed(columnWidth))
                    ]
                    
                    LazyVGrid(columns: gridColumns, spacing: 20) {
                        ForEach(Constants.sfSymbols, id: \.self) { sfSymbol in
                            Image(systemName: sfSymbol)
                                .resizable()
                                .scaledToFit()
                                .frame(width: columnWidth - 50, height: columnWidth - 50)
                        }
                    }
                    
                    NavigationLink {
                        DetailView()
                    } label: {
                        Text("Go to next page")
                    }
                }
                .navigationTitle("LazyVGrid")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
