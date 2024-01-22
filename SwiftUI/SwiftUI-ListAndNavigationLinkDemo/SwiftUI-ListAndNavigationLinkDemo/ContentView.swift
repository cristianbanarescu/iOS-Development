//
//  ContentView.swift
//  SwiftUI-ListAndNavigationLinkDemo
//
//  Created by Cristian Banarescu on 21.01.2024.
//

import SwiftUI

/*
 - Show a 'table' (List) with data inside;
 - Tap on a row goes to a 'DetailView' from where you can go back either using navigation bar or using a button
 - toolbar button to add new item to the 'table'
 - DetailView with a button together with a navigationDestination modifier in order to push another view and then be able to pop it, using .navigationDestination(isPresented: ..) modifier
 */

struct ContentView: View {
    @State private var programmingLanguages = ["Swift", "Java", "Python", "C++", "C#", "JavaScript", "Ruby", "Go", "Kotlin", "TypeScript", "Rust", "PHP", "Objective-C", "Scala", "Haskell", "Perl", "Shell", "HTML", "CSS"]

    var body: some View {
        NavigationStack {
            List(programmingLanguages, id: \.self) { language in
                NavigationLink {
                    DetailView(language: language)
                } label: {
                    Text(language)
                }
            }
            .navigationTitle("Languages")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        programmingLanguages.insert("Language: \(UUID().uuidString.prefix(6))", at: 0)
                    }, label: {
                        Text("Add")
                    })
                }
            }
        }
    }
}

struct DetailView: View {
    let language: String
    @Environment(\.dismiss) var dismiss
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(language) programming language")
            
            Spacer()
            
            Button(action: {
                dismiss()
            }, label: {
                Text("Close view/Go back")
            })
            .buttonStyle(BorderedProminentButtonStyle())
            
            Spacer()
            
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text("Go deeper")
            })
            .buttonStyle(BorderedProminentButtonStyle())
            .navigationDestination(isPresented: $isPresented) {
                Text("Deeper")
                
                Button(action: {
                    isPresented = false
                }, label: {
                    Text("Pop")
                })
                .buttonStyle(BorderedProminentButtonStyle())
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    ContentView()
}
