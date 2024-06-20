//
//  ContentView.swift
//  SwiftUI-RatingStars
//
//  Created by Cristian Banarescu on 20.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State var rating: Int = 1
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .onTapGesture {
                            rating = index
                        }
                }
            }
            
            Text("Your rating is: \(rating)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
 
