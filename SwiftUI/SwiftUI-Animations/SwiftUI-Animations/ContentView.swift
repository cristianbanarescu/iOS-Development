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
 
 Spring animations:
 
 - using the .spring or .interpolatingSpring modifiers
 */

struct ContentView: View {
    @State private var rotationAngle: CGFloat = 0
    @State private var bottomArrowRotationAngle: CGFloat = 0
    @State private var hideNotification: Bool = true

    var body: some View {
        
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.orange)
                    .frame(height: 100)
             
                Text("This notification")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.largeTitle)
            }
            .offset(y: hideNotification ? -200 : 0)
            
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
            
            Button("Show/Hide notification using spring animation") {
                withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 0)) {
                    hideNotification.toggle()
                }
            }
            .foregroundStyle(.orange)
            .bold()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
