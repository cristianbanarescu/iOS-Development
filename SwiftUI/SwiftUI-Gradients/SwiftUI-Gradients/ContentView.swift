//
//  ContentView.swift
//  SwiftUI-Gradients
//
//  Created by Cristian Banarescu on 19.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("LinearGradient ⬇️")
                Rectangle()
                    .frame(width: 200, height:  200)
                    .padding()
                    .foregroundStyle(LinearGradient(colors: [.red, .green, .blue],
                                                    startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Text("Gradient ⬇️")
                Rectangle()
                    .frame(width: 200, height:  200)
                    .padding()
                    .foregroundStyle(Gradient(colors: [.red, .green, .blue]))
                
                Text("MeshGradient ⬇️")
                Rectangle()
                    .frame(width: 200, height:  200)
                    .padding()
                    .foregroundStyle(MeshGradient(width: 3, height: 3, points: [
                        .init(0, 0), .init(0.5, 0), .init(1, 0),
                        .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
                        .init(0, 1), .init(0.5, 1), .init(1, 1)
                    ], colors: [
                        .red, .purple, .indigo,
                        .orange, .white, .blue,
                        .yellow, .green, .mint
                    ]))
                
                Text("EllipticalGradient ⬇️")
                Rectangle()
                    .frame(width: 200, height:  200)
                    .padding()
                    .foregroundStyle(EllipticalGradient(colors: [.red, .green, .blue]))
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
