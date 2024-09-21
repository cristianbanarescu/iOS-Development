//
//  ContentView.swift
//  SwiftUI-Sheets
//
//  Created by Cristian Banarescu on 19.09.2024.
//

import SwiftUI

// How to choose which View to be presented in a sheet when you have multiple options.
// Options:
// 1) using 2 Booleans (see DetailView below) to check which sheet is presented
// 2) using .sheet(item: ) and you know exactly what item will be presented; choosing the right Item based on different conditions (like the Button's action below which sets the item to be used inside the sheet)

struct SheetPresented: Identifiable {
    let text: String
    let id: String = UUID().uuidString
}

struct ContentView: View {
    
    @State var sheetPresented: SheetPresented?
    
    var body: some View {
        VStack {
            Button("Present Sheet") {
                sheetPresented = Int.random(in: 1...2) == 1 ? SheetPresented(text: "1") : SheetPresented(text: "2")
            }
        }
        .padding()
        .sheet(item: $sheetPresented) { sheet in
            Text(sheet.text)
        }
    }
}

#Preview {
//    ContentView(sheetPresented: (SheetPresented(text: "test")))
    DetailView()
}

struct DetailView: View {
    
    @State private var isSheet1Presented: Bool = false
    @State private var isSheet2Presented: Bool = false
    
    var body: some View {
        VStack {
            Button("Present Sheet") {
                let randomResult = Int.random(in: 1...2)
                if randomResult == 1 {
                    isSheet1Presented = true
                } else {
                    isSheet2Presented = true
                }
            }
        }
        .padding()
        .sheet(isPresented: $isSheet1Presented) {
            Text("1")
        }
        .sheet(isPresented: $isSheet2Presented) {
            Text("2")
        }
    }
}
