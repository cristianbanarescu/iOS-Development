//
//  ContentView.swift
//  SwiftUI-TextAlignmentDemo
//
//  Created by Cristian Banarescu on 20.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Spacer()
        
        HStack {
            Text("No")
            Text("Text")
                .font(.largeTitle)
            Text("Baseline")
        }
        .font(.title)
        .frame(width: 200)
        .background(.red.opacity(0.2))
        
        Spacer()
        
        // First text baseline stack
        HStack(alignment: .firstTextBaseline) { // align texts at the 'top' of them
            Text("First")
            Text("Text")
                .font(.largeTitle)
            Text("Baseline")
        }
        .font(.title)
        .frame(width: 200)
        .background(.red.opacity(0.2))
        
        Spacer()
        
        // Last text baseline stack
        HStack(alignment: .lastTextBaseline) { // align texts at the 'bottom' of them
            Text("Last")
            Text("Text")
                .font(.largeTitle)
            Text("Baseline")
        }
        .font(.title)
        .frame(width: 200)
        .background(.red.opacity(0.2))
        
        Spacer()
    }
}

#Preview {
    ContentView()
}
