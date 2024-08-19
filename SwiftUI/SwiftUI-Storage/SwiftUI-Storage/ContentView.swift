//
//  ContentView.swift
//  SwiftUI-Storage
//
//  Created by Cristian Banarescu on 19.08.2024.
//

import SwiftUI

/*
 
 Working with @AppStorage:
 
 - Reads values from UserDefaults and refreshes the view (body property) when those value change
 - https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-appstorage-property-wrapper
 - See https://medium.com/@herlinaastari/store-a-custom-object-with-userdefaults-in-swift-5-2bbacfd92c8a on how to store and read custom objects from UserDefaults, UIKit's style
 - Storing Custom Objects in @AppStorage in SwiftUI: https://www.youtube.com/watch?v=tdyT_v4lwos
 - In order to store custom objects to AppStorage, we need to actually convert those objects into Data objects using JSONEncoder and when we need to 'read' the value, we need to decode the saved data using JSONDecoder
 
 */

struct Person: Codable {
    let name: String
    let age: Int
}

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("savedNumber") private var myNumber = 0
    @AppStorage("savedPerson") private var savedPersonData: Data?
    @State private var loadedPerson: Person?
    
    var body: some View {
        VStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 100, height: 100)
                .foregroundStyle(isDarkMode ? .black : .red)
            
            Spacer()
            
            Button("Toggle Dark Mode") {
                isDarkMode.toggle()
            }
            
            Button("Save Number") {
                myNumber += 1
            }
            
            Text("Saved Number: \(myNumber)")
            
            Spacer()
            
            Button("Save Person") {
                let person = Person(name: "Cristian", age: 25)
                let savedPersonData = try? JSONEncoder().encode(person) // write to user defaults using Data, not Person
                if let savedPersonData { // Data object to be written to UserDefaults
                    self.savedPersonData = savedPersonData
                }
            }
            
            Button("Load Person") {
                if let savedPersonData = savedPersonData {
                    // read from UserDefaults using JSONDecoder
                    if let loadedPerson = try? JSONDecoder().decode(Person.self, from: savedPersonData) { // data object converted to a Person object
                        self.loadedPerson = loadedPerson
                    }
                }
            }
            
            Text("Loaded person data: \(loadedPerson?.name ?? "N/A"), \(loadedPerson?.age ?? 0)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
