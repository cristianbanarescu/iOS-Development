//
//  MultipleNavigationView.swift
//  SwiftUI-NavigationLinkDemo
//
//  Created by Cristian Banarescu on 13.01.2024.
//

import Foundation
import SwiftUI

/*
 Use the following code if you want to use a NavigationStack in which you can 'push' multiple views + pop to 'root' View. Behavior similar to how UIKit + UINavigationController works
 
 Based on information from:
 - https://sarunw.com/posts/how-to-pop-to-root-view-in-swiftui/
 */

struct Path: Hashable {
    let name: String
}

struct MultipleNavigationView: View {
    @State private var path: [Path] = [] // NavigationPath object - see doc; basically a variable that is a collection of an object; can be a custom object or String, Int, etc (Hashable objects)

    var body: some View {
        NavigationStack(path: $path) { // use this init of NavigationStack
            Button(action: {
                path.append(Path(name: "First")) // push the first view to the 'stack' of existing views
            }, label: {
                Text("Start navigation")
            })
            .buttonStyle(BorderedProminentButtonStyle())
            .font(.title)
            .navigationDestination(for: Path.self) { path in // associate a MultipleNavigationDetailView with the array of Path
                MultipleNavigationDetailView(path: $path) // pass Path as a Binding to the 'Detail view'; this way, you create a connection between the 'root' view and its pushed 'children'
            }
            .navigationTitle("NavigationLink Demo")
        }
    }
}

struct MultipleNavigationDetailView: View {
    @Binding var path: [Path]
    
    var body: some View {
        NavigationStack(path: $path) { // again use this init in order to be able to further push views
            VStack {
                Button("Pop to first view") {
                    path.removeAll() // remove all views from the 'stack'; basically will 'pop to root view'
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .font(.title)
                .tint(.red)
                
                Button("Push an extra view") {
                    path.append(Path(name: "\(UUID().uuidString.prefix(6))")) // push new views to the 'stack' of existing views
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .font(.title)
            }
            .navigationTitle(UUID().uuidString.prefix(6))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MultipleNavigationView()
}

