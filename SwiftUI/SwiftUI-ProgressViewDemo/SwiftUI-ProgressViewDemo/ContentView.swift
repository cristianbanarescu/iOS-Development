//
//  ContentView.swift
//  SwiftUI-ProgressViewDemo
//
//  Created by Cristian Banarescu on 28.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentDate = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Text("Simple: ")
                ProgressView() // like an activity indicator view ; loading ...
                    .tint(.green)
                    .controlSize(.extraLarge)
            }
            
            HStack {
                Text("X/Y:")
                ProgressView(value: 30, total: 100)
            } // 30/100 progress; simple progress view with a value out of total
            
            HStack {
                Text("ProgressView with a label describing it:")
                ProgressView { // activity indicator view + a label describing it
                    Text("Loading...")
                }
                .controlSize(.large)
            } // how to increase the size of the progressView
            
            HStack {
                Text("X/Y + description of progress view")
                ProgressView("30/100", value: 30, total: 100)
            }  // 30/100 progress; simple progress view with a value out of total and also a description of the progress view
            
            HStack {
                Text("X/Y + custom label for the progressview")
                ProgressView(value: 30, total: 100) {  // 30/100 progress; simple progress view with a custom label describing the progress view
                    Text("30/100")
                        .font(.system(size: 40))
                        .foregroundStyle(.brown)
                }
            }
            
            ProgressView(timerInterval: Date()...Date(timeIntervalSinceNow: 10)) // countdown timer
                .padding()
            
            ProgressView(timerInterval: currentDate...Date(timeIntervalSinceNow: 10)) {
                Text("Countdown 10 seconds")
            }
            
            Button("Reset countdown") {
                currentDate = Date()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
