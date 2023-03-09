//
//  ContentView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkService = NetworkService()
    
    var body: some View {
        VStack {
            List {
                Section("WKWebView based") {
                    ForEach(networkService.news) { data in
                        Text(data.title)
                    }
                }
                Section("SFSafariViewController based") {
                    ForEach(networkService.news) { data in
                        Text(data.title)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            networkService.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
