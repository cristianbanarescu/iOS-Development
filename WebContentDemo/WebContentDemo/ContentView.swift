//
//  ContentView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkService = NetworkService()
    @State var wkWebViewPresented: Bool
    @State var safariPresented: Bool
    @State var webBasedViewProvider: WebContentViewProvider
    @State var safariBasedViewProvider: WebContentViewProvider
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // TODO refactor this code inside some 'service' class
                    Section("WKWebView based") {
                        ForEach(networkService.news) { data in
                            Button(data.title) {
                                wkWebViewPresented.toggle()
                                webBasedViewProvider = WKWebViewProvider(urlString: "\(data.url ?? "unknown string")")
                            }
                            .sheet(isPresented: $wkWebViewPresented) {
                                DetailView(webBasedViewProvider: $webBasedViewProvider)
                            }
                        }
                    }
                    Section("SFSafariViewController based") {
                        ForEach(networkService.stories) { data in
                            Button(data.title) {
                                safariPresented.toggle()
                                safariBasedViewProvider = SafariViewControllerViewProvider(urlString: "\(data.url ?? "unknown string")")
                            }
                            .sheet(isPresented: $safariPresented) {
                                DetailView(webBasedViewProvider: $safariBasedViewProvider)
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
        ContentView(wkWebViewPresented: false, safariPresented: false, webBasedViewProvider: WKWebViewProvider(urlString: ""), safariBasedViewProvider: SafariViewControllerViewProvider(urlString: ""))
    }
}
