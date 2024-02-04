//
//  ContentView.swift
//  SwiftUI-StepperDemo
//
//  Created by Cristian Banarescu on 04.02.2024.
//

import SwiftUI

/*
- Stepper - binding to a value in order to get or set the stepper's value
- you can provide a range of values using the 'in' param of stepper's init
- plus or minus buttons will be disabled when reaching the bounds of the range (lower or upper bound)
 */

struct ContentView: View {
    @State var stepperValue: Int = 0
    
    var body: some View {
        VStack {
            Stepper(value: $stepperValue, in: 0...10) { // Stepper with custom 'Label'
                HStack {
                    Spacer()
                    Text("My Stepper")
                    Spacer()
                }
                .background(.red)
            }
            
            Text("Stepper value: \(stepperValue)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
