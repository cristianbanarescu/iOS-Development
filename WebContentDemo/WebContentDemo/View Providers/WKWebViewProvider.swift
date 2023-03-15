//
//  WKWebViewProvider.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 12.03.2023.
//

import SwiftUI

struct WKWebViewProvider: WebContentViewProvider {
    var urlString: String

    var view: AnyView {
        AnyView(WebView(urlString: urlString))
    }
}
