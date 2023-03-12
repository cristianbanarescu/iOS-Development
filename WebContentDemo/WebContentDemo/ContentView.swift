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
                            NavigationLink(data.title) {
                                DetailView(urlString: "\(data.url ?? "unknown string")")
                            }
                        }
                    }
                    Section("SFSafariViewController based") {
                        ForEach(networkService.stories) { data in
                            NavigationLink(data.title) {
                                DetailView(urlString: "\(data.url ?? "unknown string")")
                            }
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
