//
//  ContentView.swift
//  SwiftUI-FormDemo
//
//  Created by Cristian Banarescu on 01.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var rowExpanded: Bool = false
    @State private var toggleOn: Bool = false
    
    var body: some View {
        Form {
            Text("Form demo")
                .font(.largeTitle)
            Text("Different sections inside the form. Different configurations")
            
            Section {
                Text("Row inside section 1")
            } header: {
                Text("Section 1")
            }
            
            Section {
                Text("Row inside section 2")
            } header: {
                Text("Section 2")
            } footer: {
                Text("Section 2 footer")
                    .italic()
            }
            
            Section {
                Text("Row inside section 3")
            } header: {
                Text("Section 3")
            } footer: {
                Text("Section 3 footer")
                    .bold()
            }
            .headerProminence(.increased)
            
            Section {
                Text("Row inside section 4 - with background")
                    .listRowBackground(Color.red.opacity(0.3))
            } header: {
                Text("Section 4")
            }
            
            Section {
                Text("Row inside section 5 - with background")
                Text("Row inside section 5 - with background")
                    .listRowBackground(Color.red.opacity(0.3))
            } header: {
                Text("Section 5")
            }
            .listRowBackground(Color.blue.opacity(0.4))
            
            Section {
                Text("Row inside section 6 - row insets")
                    .listRowInsets(EdgeInsets(top: 0, leading: 70, bottom: 20, trailing: 0))
            } header: {
                Text("Section 6")
            }
            
            // Use DisclosureGroup to show or hide other content view, using a 'chevron'
            DisclosureGroup(
                isExpanded: $rowExpanded,
                content: {
                    Text("Content")
                    Toggle(isOn: $toggleOn, label: {
                        Text("Label")
                    })
                },
                label: { 
                    Text("Disclosure group - show or hide")
                }
            )
            .tint(.black)
        }
    }
}

#Preview {
    ContentView()
}
