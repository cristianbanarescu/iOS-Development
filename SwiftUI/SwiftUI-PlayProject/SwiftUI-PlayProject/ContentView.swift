//
//  ContentView.swift
//  SwiftUI-PlayProject
//
//  Created by Cristian Banarescu on 23.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    var body: some View {
        VStack {
            Text("Count: \(counter)")
            Button("Increment") { counter += 1 }
            let _ = Self._printChanges()
        }
    }
}

#Preview {
    ContentView()
}
