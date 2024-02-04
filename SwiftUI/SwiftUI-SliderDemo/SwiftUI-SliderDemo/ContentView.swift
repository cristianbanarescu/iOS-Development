//
//  ContentView.swift
//  SwiftUI-SliderDemo
//
//  Created by Cristian Banarescu on 04.02.2024.
//

import SwiftUI

/*
 
 - Slider default values: 0.0 > 1.0
 - use the 'in' param to specify the interval for Slider's values
 - use a Binding variable to get or set the value of the Slider
 - use the step param from the init to specify how the Slider increments
 - use minimumValueLabel and maximumValueLabel to specify some 'margins' for the Slider
 - use tint modifier to change the color of the slider's progress 
 */

struct ContentView: View {
    @State var sliderValue: Float = 100
    
    var body: some View {
        VStack {
            Slider(value: $sliderValue, in: 100...1000, step: 100) {
                Text("Slider")
            } minimumValueLabel: {
                Text("Min")
            } maximumValueLabel: {
                Text("Max")
            }
            .padding()
            .background(Capsule().stroke(.cyan, lineWidth: 3))
            .tint(.brown)

            Text(String(format: "Slider value is: %.0f", sliderValue))
            
            Button("Set slider to half value") {
                sliderValue = 500
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
