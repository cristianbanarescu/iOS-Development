//
//  ContentView.swift
//  SwiftUIOpaqueTypes
//
//  Created by Cristian Banarescu on 17.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ContentViewWithError: View {
    var isEnabled = true

    /*
     Function declares an opaque return type 'some View', but the return statements in its body do not have matching underlying types
     */
    var body: some View {
        if isEnabled {
            return Color.red
        } else {
            return Text("Hello, world!")
        }
    }
}
