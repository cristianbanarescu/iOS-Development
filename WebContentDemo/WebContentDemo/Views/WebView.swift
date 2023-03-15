//
//  WebView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 14.03.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @Binding var urlString: String
    
    typealias UIViewType = WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        uiView.load(URLRequest(url: url))
    }
}
