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
 
 TODO: Pop to root with multiple views:
 - https://sarunw.com/posts/how-to-pop-to-root-view-in-swiftui/
 - https://www.hackingwithswift.com/forums/swiftui/navigationstack-pop-to-root/24439
 - https://stackoverflow.com/questions/57334455/how-can-i-pop-to-the-root-view-using-swiftui
 */

struct ContentView: View {
    var body: some View {
        NavigationStack {
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
            .navigationTitle("NavigationLink Demo")
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Destination")
                Button("Pop/Dismiss") {
                    dismiss()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .font(.title)
            }
            .navigationTitle("Second View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
