//
//  ContentView.swift
//  SwiftUI-DisclosureGroupDemo
//
//  Created by Cristian Banarescu on 14.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // plain disclosure group
            DisclosureGroup("Simple Disclosure Group") {
                Text("This is the content of the disclosure group.")
            }
            
            // disclosure group with custom label
            DisclosureGroup {
                Text("This is the content of the disclosure group.")
            } label: {
                Text("DisclosureGroup with custom properties here")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
            }
            
            // disclosure group with isExpanded Bool
            DisclosureGroup("DisclosureGroup with expanded Bool", isExpanded: $isExpanded) {
                Text("This is the content of the disclosure group.")
            }
            
            Spacer()

            Text("Last disclosure group isExpanded: \(isExpanded)")
            
            Spacer()
            
            // TODO: disclosuregroup with custom style
            
            DisclosureGroup {
                Text("This is the content of the disclosure group.")
            } label: {
                Text("DisclosureGroup with custom properties here")
            }
            .disclosureGroupStyle(MyStyle())
            
            let data =
              FileItem(name: "users", children:
                [FileItem(name: "user1234", children:
                  [FileItem(name: "Photos", children:
                    [FileItem(name: "photo001.jpg"),
                     FileItem(name: "photo002.jpg")]),
                   FileItem(name: "Movies", children:
                     [FileItem(name: "movie001.mp4")]),
                      FileItem(name: "Documents", children: [])
                  ]),
                 FileItem(name: "newuser", children:
                   [FileItem(name: "Documents", children: [])
                   ])
                ])

            /*
             A view that can represent a hierarchy of data.
             
             This allows the user to navigate a tree structure by using disclosure views to expand and collapse branches.
             */
            OutlineGroup(data, children: \.children) { item in
                Text("\(item.description)")
            }
        }
        .padding()
    }
}

struct FileItem: Hashable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    var name: String
    var children: [FileItem]? = nil
    var description: String {
        switch children {
        case nil:
            return "📄 \(name)"
        case .some(let children):
            return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
        }
    }
}

struct MyStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label
                Spacer()
                Button {
                    withAnimation {
                        configuration.isExpanded.toggle()
                    }
                } label: {
                    Text("\(configuration.isExpanded ? "Hide" : "Show")")
                        .foregroundStyle(.pink)
                        .underline()
                }
            }
            
            if configuration.isExpanded {
                configuration.content
            }
        }
        
    }
}

#Preview {
    ContentView()
}
