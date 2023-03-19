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
                    WKWebViewBasedSectionProvider(
                        networkService: networkService,
                        isPresented: $wkWebViewPresented,
                        viewProvider: $webBasedViewProvider
                    )
                    SafariBasedSectionProvider(
                        networkService: networkService,
                        isPresented: $safariPresented,
                        viewProvider: $safariBasedViewProvider
                    )
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
        ContentView(
            wkWebViewPresented: false,
            safariPresented: false,
            webBasedViewProvider: WKWebViewProvider(urlString: ""),
            safariBasedViewProvider: SafariViewControllerViewProvider(urlString: "")
        )
    }
}
