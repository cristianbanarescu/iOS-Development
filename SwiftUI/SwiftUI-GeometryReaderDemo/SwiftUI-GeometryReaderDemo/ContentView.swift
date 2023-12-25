//
//  ContentView.swift
//  SwiftUI-GeometryReaderDemo
//
//  Created by Cristian Banarescu on 25.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        GeometryReader { geometry in
            // geometry is of type GeometryProxy -> object that gives you size and coordinate space of the container view
            VStack(alignment: .leading) {
                Text("Width: \(geometry.size.width)")
                Text("Height: \(geometry.size.height)")
                Text("top safe area insets: \(geometry.safeAreaInsets.top)")
                Text("leading safe area insets: \(geometry.safeAreaInsets.leading)")
                Text("trailing safe area insets: \(geometry.safeAreaInsets.trailing)")
                Text("bottom safe area insets: \(geometry.safeAreaInsets.bottom)")
                
                Spacer()
                
                Text("Using geometry's size for other child views")
                    .foregroundStyle(.white)
                
                VStack(alignment: .leading) {
                    Circle()
                        .frame(width: geometry.size.width / 6, height: geometry.size.height / 6 - 10)
                        .position(x: geometry.size.width - 100, y: geometry.size.height / 3)
                    
                    Circle()
                        .frame(width: geometry.size.width / 3, height: geometry.size.height / 3 - 20)
                
                    Circle()
                        .frame(width: geometry.size.width / 2, height: geometry.size.height / 3)
                }
            }
            .offset(x: 30)
        }
        .background(.red)
        
        VStack {
            // Coordinates of the GeometryReader inside the parent view
            GeometryReader { geometryProxy in
                VStack(alignment: .leading) {
                    Text("x position: \(geometryProxy.frame(in: .global).origin.x)")
                    Text("y position: \(geometryProxy.frame(in: .global).origin.y)")
                }
            }
        }
        .offset(x: 50, y: 100)
    }
}

#Preview {
    ContentView()
}
