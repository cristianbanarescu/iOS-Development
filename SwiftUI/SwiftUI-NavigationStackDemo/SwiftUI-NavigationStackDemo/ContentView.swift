//
//  ContentView.swift
//  SwiftUI-NavigationStackDemo
//
//  Created by Cristian Banarescu on 07.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isNavBarHidden = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isNavBarHidden {
                    Divider()
                } else { // custom navigation bar with custom background
                    Divider()
                        .background(.red)
                }
                
                Spacer()
                
                Button(action: { // show/hide nav bar
                    isNavBarHidden.toggle()
                }, label: {
                    Text("Show/Hide nav bar")
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .foregroundStyle(.white)
                
                Spacer()
                
                NavigationLink { // use this to go from the 'main' view to other (detail) view
                    DetailView()
                } label: {
                    Text("Go to next view")
                }
                
                Spacer()
            }
            .background(.red.opacity(0.5))
            .navigationTitle("Navigation title") // As the view inside the NavigationStack will change, the contents of the navigation stack will change; this view will dictate the title of the navigation stack; (ie the navigation stack's title is 'subject to change' based on what the View inside it does)
            // SwiftUI can change the title inside the navigation stack as the content changes
            // See more here: https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
            //            .navigationBarTitleDisplayMode(.inline) // Smaller navigation bar
            .toolbar(isNavBarHidden ? .hidden : .visible, for: .navigationBar) // https://developer.apple.com/documentation/swiftui/view/toolbar(_:for:)
            .toolbar { // create buttons on the navigation bar
                ToolbarItem {
                    EditButton()
                        .tint(.white)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Call button", systemImage: "phone") {
                        // call someone
                    }
                    .tint(.white)
                }
                
                ToolbarItem(placement: .principal) { // button in the middle of the nav bar -> placement: .principal
                    EditButton()
                        .tint(.black)
                }
            }
        }
        .onAppear {
            /*
             let navBarAppearance = UINavigationBarAppearance()
             navBarAppearance.backgroundColor = UIColor(.green.opacity(0.7))
             
             UINavigationBar.appearance().standardAppearance = navBarAppearance
             UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
             */
            
            // use the above code to set the backgroundColor for all navigation bars in the app
        }
    }
}

#Preview {
    ContentView()
}

/*
 How to replace the default back button from the navigation bar with a custom one:
 
 1 - hide the default button > .navigationBarBackButtonHidden()
 2 - create a new button using .toolbar and ToolbarItem and use placement: .topBarLeading
 
 */
struct DetailView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("Hello next view!")
            .navigationBarBackButtonHidden() // hide the default back button from the navigation bar
            .navigationTitle("Next View")
            .toolbar { // create a custom back bar button
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // close the screen
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
    }
}
