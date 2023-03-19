//
//  WKWebViewBasedSectionProvider.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 19.03.2023.
//

import SwiftUI

struct WKWebViewBasedSectionProvider: View {
    
    // MARK: - Properties

    @ObservedObject var networkService: NetworkService
    @Binding var isPresented: Bool
    @Binding var viewProvider: WebContentViewProvider
    
    var body: some View {
        Section("WKWebView based") {
            ForEach(networkService.news) { data in
                Button(data.title) {
                    isPresented.toggle()
                    viewProvider = WKWebViewProvider(urlString: "\(data.url ?? "unknown string")")
                }
                .sheet(isPresented: $isPresented) {
                    DetailView(webBasedViewProvider: $viewProvider)
                }
            }
        }
    }
}
