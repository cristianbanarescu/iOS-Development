//
//  ContentView.swift
//  Pulse
//
//  Created by Cristian Banarescu on 20.12.2025.
//

import SwiftUI

/*
 - views are cheap (structs)
 - views are disposable
 - SwiftUI recreates views often
 - uses structs because you don't have to worry about shared references or side effects like you do with classes
 - some View - opaque return type; the compiler knows it at compile time but you don't have to spell it out; without 'some View' your return type would be complex and unreadable 
 */

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Pulse")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("SwiftUI Learning Project")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
