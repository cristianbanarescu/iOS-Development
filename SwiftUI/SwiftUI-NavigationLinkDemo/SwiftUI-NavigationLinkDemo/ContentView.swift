//
//  ContentView.swift
//  SwiftUI-NavigationLinkDemo
//
//  Created by Cristian Banarescu on 12.01.2024.
//

import SwiftUI

/*
 Demo app:
 
 - use a NavigationLink to navigate to SecondView
 - use a button inside SecondView to 'pop' back to the 'root' view
 */

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // use NavigationLink to navigate to other views
                NavigationLink(destination: SecondView()) {
                    Text("Click me!")
                        .padding()
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 1000)
                                .foregroundStyle(.red)
                        }
                }
                // creates a 'button' that can be used to navigate to another view
                // in this case, navigation will be performed to a Text view
            }
            .padding()
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Destination")
            Button("Pop/Dismiss") {
                dismiss()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .font(.title)
        }
    }
}

#Preview {
    ContentView()
}
