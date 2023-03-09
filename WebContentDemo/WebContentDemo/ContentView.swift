//
//  ContentView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                Section("WKWebView based") {
                    ForEach(webViewData) { data in
                        Text(data.title)
                    }
                }
                Section("SFSafariViewController based") {
                    ForEach(safariVCData) { data in
                        Text(data.title)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Data: Identifiable { // TODO to rename and move to separate file after fetching data from an API 
    let id: String = UUID().uuidString
    let title: String
}

let webViewData: [Data] = [
    Data(title: "1"),
    Data(title: "1"),
    Data(title: "1"),
    Data(title: "1"),
    Data(title: "1")
]

let safariVCData: [Data] = webViewData
