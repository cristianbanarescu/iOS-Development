//
//  DetailView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

struct DetailView: View {
    
    var webBasedService: any WebContentViewProvider
    
    var body: some View {
        webBasedService.view
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(webBasedService: WKWebViewProvider(urlString: "https://google.com"))
    }
}
