//
//  ContentView.swift
//  SwiftUI-DatePickerDemo
//
//  Created by Cristian Banarescu on 01.01.2024.
//

import SwiftUI

/*
 Demonstration of different date pickers and styles.
 */

struct ContentView: View {
    @State private var date: Date = Date()
    @State private var formScreenOpened: Bool = false
    
    var body: some View {
        Text("DatePicker styles")
            .font(.largeTitle)
        
        ScrollView {
            Spacer()
            
            DatePicker(selection: $date) {
                Text("Graphical date")
            }
            .datePickerStyle(.graphical)
            .padding(30)
            
            Spacer()
            
            DatePicker(selection: $date) {
                Text("Automatic date")
            }
            .datePickerStyle(.automatic)
            .padding(30)
            
            Spacer()
            
            DatePicker(selection: $date) {
                Text("Compact date")
            }
            .datePickerStyle(.compact)
            .padding(30)
            
            Spacer()
            
            DatePicker(selection: $date) {
                Text("Wheel date")
            }
            .datePickerStyle(.wheel)
            .padding(5)
            
            Spacer()
            
            DatePicker(selection: $date, displayedComponents: .date) {
                Text("Wheel date - only date")
            }
            .datePickerStyle(.wheel)
            .padding(5)
            
            Spacer()
            
            DatePicker(selection: $date, displayedComponents: .hourAndMinute) {
                Text("Compact date - only hour and minute")
            }
            .datePickerStyle(.compact)
            .padding(30)
            
            Spacer()
            
            Button {
                formScreenOpened.toggle()
            } label: {
                Text("Open the form screen")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .sheet(isPresented: $formScreenOpened, content: {
            Form {
                DatePicker("Date", selection: $date)
            }
        })
    }
}

#Preview {
    ContentView()
}
