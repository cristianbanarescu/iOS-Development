//
//  ContentView.swift
//  SwiftUI-CoreData
//
//  Created by Cristian Banarescu on 25.06.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var coredataService: CoreDataService = .shared
    
    var body: some View {
        NavigationView {
            List {
                ForEach(coredataService.items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: coredataService.deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: coredataService.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
