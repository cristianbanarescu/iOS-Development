//
//  DetailView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

struct DetailView: View {
    
    var urlString: String
    var webBasedService: WebContentService
    
    var body: some View {
        Text(urlString)
            .onAppear {
                webBasedService.loadURL()
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(urlString: "https://google.com", webBasedService: WKWebViewService())
    }
}
