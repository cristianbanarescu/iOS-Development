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
        }
        .frame(height: 200)
    }
}

#Preview {
    ContentView()
}
