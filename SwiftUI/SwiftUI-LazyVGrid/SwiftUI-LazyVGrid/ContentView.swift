//
//  ContentView.swift
//  SwiftUI-LazyVGrid
//
//  Created by Cristian Banarescu on 19.08.2024.
//

import SwiftUI

/*
 - LazyVGrid > A container view with child views arranged in a grid that grows vertically
 - creating items only as needed.
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
 - use GridItem to specify what layout you want
 - LazyVGrid + GridItem => Grid with columns
 - LazyHGrid > grid with rows 

 */

struct ContentView: View {
    var body: some View {
        ScrollView {
            
            // adaptive > Multiple items in the space of a single flexible item.
            // GridItem(.adaptive(minimum: 100)) -> kind of like multiple columns inside a single column (GridItem)
            // GridItem(.adaptive(minimum: 100)) -> make the grid to fit in as many items per row as possible, using a minimum size of 100 each.
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 300))], spacing: 30) {
                ForEach(0..<100) { index in
                    Text("\(index)")
                        .frame(width: 100, height: 100)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            
            // fixed > A single item with the specified fixed size.
            // GridItem(.fixed(100)) means a single column of fixed size 100
            
//            LazyVGrid(columns: [GridItem(.fixed(100))]) {
//                ForEach(0..<100) { index in
//                    Text("\(index)")
//                        .frame(width: 200, height: 100)
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
//            }
            
            // flexible > A single item with 'relative' size (NOT fixed)
            
//            LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: 300))]) {
//                ForEach(0..<100) { index in
//                    Text("\(index)")
//                        .frame(width: 300, height: 100)
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
//            }
            
        }
    }
}

#Preview {
    ContentView()
}
