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
        NavigationView {
            VStack {
                List {
                    Section("WKWebView based") {
                        ForEach(networkService.news) { data in
                            Text(data.title)
                        }
                    }
                    Section("SFSafariViewController based") {
                        ForEach(networkService.stories) { data in
                            Text(data.title)
                        }
                    }
                }
            }
            .navigationTitle("My awesome news")
        }
        .onAppear {
            networkService.fetchDataFromFrontPageAndStories()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
