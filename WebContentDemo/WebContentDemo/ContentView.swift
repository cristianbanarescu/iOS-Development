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
                    // TODO refactor this code inside some 'service' class
                    Section("WKWebView based") {
                        ForEach(networkService.news) { data in
                            NavigationLink(data.title) {
                                // TODO open a WebView - using WKWebView
                                DetailView(
                                    urlString: "\(data.url ?? "unknown string")",
                                    webBasedService: WKWebViewService()
                                )
                            }
                        }
                    }
                    Section("SFSafariViewController based") {
                        ForEach(networkService.stories) { data in
                            NavigationLink(data.title) {
                                // TODO open a SafariView that loads a SafariVC with the URL String
                                DetailView(
                                    urlString: "\(data.url ?? "unknown string")",
                                    webBasedService: SafariViewControllerService()
                                )
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
