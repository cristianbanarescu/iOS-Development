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
                    Text("Present data using WKWebView")
                    Text("Present data using WKWebView")
                    Text("Present data using WKWebView")
                    Text("Present data using WKWebView")
                    Text("Present data using WKWebView")
                }
                Section("SFSafariViewController based") {
                    Text("Present data using SFSafariViewController")
                    Text("Present data using SFSafariViewController")
                    Text("Present data using SFSafariViewController")
                    Text("Present data using SFSafariViewController")
                    Text("Present data using SFSafariViewController")
                    Text("Present data using SFSafariViewController")
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
