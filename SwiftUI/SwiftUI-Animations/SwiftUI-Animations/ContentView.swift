//
//  ContentView.swift
//  SwiftUI-Animations
//
//  Created by Cristian Banarescu on 07.07.2024.
//

import SwiftUI

/*
 2 ways of rotating the arrows:
 
 - using the .animation modifier which applies an animation you specify when the 'value' param changes
 - using withAnimation function which recomputes the View body using the specified animation
 */

struct ContentView: View {
    @State private var rotationAngle: CGFloat = 0
    @State private var bottomArrowRotationAngle: CGFloat = 0

    var body: some View {
        
        VStack {
            Spacer()
            
            Text("Top arrow")
            Image(systemName: "arrowshape.right.fill")
                .resizable()
                .imageScale(.large)
                .foregroundStyle(.tint)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: rotationAngle))
                .animation(.bouncy, value: rotationAngle) // animate the change of rotationAngle
            
            Spacer()
            
            Text("Bottom arrow")
            Image(systemName: "arrowshape.left.fill")
                .resizable()
                .imageScale(.large)
                .foregroundStyle(.tint)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: bottomArrowRotationAngle))
            
            Spacer()
            
            Button("Rotate top arrow") {
                rotationAngle += 90
            }
            .foregroundStyle(.red)
            .bold()
            
            Button("Rotate bottom arrow") {
                withAnimation(.bouncy) { // animate the change of bottomArrowRotationAngle
                    bottomArrowRotationAngle += 90
                }
            }
            .bold()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
