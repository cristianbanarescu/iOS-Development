//
//  ContentView.swift
//  SwiftUI-LayersDemo
//
//  Created by Cristian Banarescu on 20.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 200, height: 200)
                .background( // adds a Circle behind the Image
                    Circle()
                        .foregroundStyle(.red)
                )
            // https://developer.apple.com/documentation/swiftui/view/background(alignment:content:)
                .overlay { // adds a Text on top of the Image
                    Text("On top")
                        .font(.title)
                        .foregroundStyle(.white)
                }
            // https://developer.apple.com/documentation/swiftui/view/overlay(alignment:content:)
        }
    }
}

#Preview {
    ContentView()
}
