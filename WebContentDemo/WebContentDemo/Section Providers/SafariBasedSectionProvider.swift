//
//  SafariBasedSectionProvider.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 19.03.2023.
//

import SwiftUI

struct SafariBasedSectionProvider: View {
    @ObservedObject var networkService: NetworkService
    @Binding var isPresented: Bool
    @Binding var viewProvider: WebContentViewProvider
    
    var body: some View {
        Section("SFSafariViewController based") {
            ForEach(networkService.stories) { data in
                Button(data.title) {
                    isPresented.toggle()
                    viewProvider = SafariViewControllerViewProvider(urlString: "\(data.url ?? "unknown string")")
                }
                .sheet(isPresented: $isPresented) {
                    DetailView(webBasedViewProvider: $viewProvider)
                }
            }
        }
    }
}

