//
//  ContentView.swift
//  WeSplit
//
//  Created by Cristian Banarescu on 11.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    private var currentLocaleIdentifier: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    var body: some View {
        Form {
            Section("Amount") {
                TextField("Enter check amount", value: $checkAmount, format: .currency(code: currentLocaleIdentifier))
                    .keyboardType(.decimalPad)
            }
            
            Section("Value of check") {
                Text(checkAmount, format: .currency(code: currentLocaleIdentifier))
            }
        }
    }
}

#Preview {
    ContentView()
}
