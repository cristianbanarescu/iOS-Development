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
                .modifier(PrimaryButtonStyle())
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func primaryButtonStyle() -> some View {
        modifier(PrimaryButtonStyle())
    }
}

struct PrimaryButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .background(Color.blue)
      .foregroundColor(.white)
      .clipShape(Capsule())
  }
}
