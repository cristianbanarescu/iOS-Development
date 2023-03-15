//
//  DetailView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var webBasedViewProvider: any WebContentViewProvider
    
    var body: some View {
        webBasedViewProvider.view
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(webBasedViewProvider: .constant(WKWebViewProvider(urlString: "https://google.com")))
    }
}
