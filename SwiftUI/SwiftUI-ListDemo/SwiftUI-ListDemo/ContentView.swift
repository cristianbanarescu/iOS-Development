//
//  ContentView.swift
//  SwiftUI-ListDemo
//
//  Created by Cristian Banarescu on 02.01.2024.
//

import SwiftUI

/*
 Use .onMove on a ForEach to make the rows from the List movable
    onMove and onDelete come from the DynamicViewContent protocol
 
 Also need a NavigationStack to embed all the other views so I can then add a .toolbar with a ToolbarItem inside
 */

struct ContentView: View {
    @State private var famousMusicians = ["John Lennon", "Bob Dylan", "Elvis Presley", "Michael Jackson", "Prince", "David Bowie", "Aretha Franklin", "Freddie Mercury", "Beyoncé", "Johnny Cash", "Miles Davis", "Jimi Hendrix", "Madonna", "Frank Sinatra", "Eminem", "Whitney Houston", "Stevie Wonder", "Janis Joplin", "Bob Marley", "Taylor Swift"]
    @State private var listSelection: Set<String> = [] // to use for multiple selection
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Famous musicians below:")
                    .padding(.horizontal, 25)
                
                // List needs to know how to uniquely identify each row (needs this for operations like row reordering or deletions)
                // id: \.self > just use the value of the string itself to uniquely identify the rows
                List(selection: $listSelection) {
                    ForEach(famousMusicians, id: \.self) { musicianName in
                        if musicianName.contains("Beyonc") {
                            DisclosureGroup(
                                content: { Text(musicianName)
                                    .selectionDisabled(false) },
                                label: { Text("Christmas song artists") }
                            )
                            .selectionDisabled()
                        } else {
                            Text(musicianName)
                        }
                    }
                    .onMove(perform: { indices, newOffset in
                        famousMusicians.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .onDelete { indexSet in
                        famousMusicians.remove(atOffsets: indexSet)
                    }
                }
//                .listStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=List Style@*/DefaultListStyle()/*@END_MENU_TOKEN@*/)
                .toolbar {
                    ToolbarItem {
                        EditButton() // built in button that makes the rows editable; changes its title to 'Done' when tapped
                    }
                    ToolbarItem {
                        Button(action: {
                            famousMusicians.insert("Musician \(Int.random(in: 1...100))", at: 0)
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
