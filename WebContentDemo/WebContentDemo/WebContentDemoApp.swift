//
//  WebContentDemoApp.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

@main
struct WebContentDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                wkWebViewPresented: false,
                safariPresented: false,
                webBasedViewProvider: WKWebViewProvider(urlString: ""),
                safariBasedViewProvider: SafariViewControllerViewProvider(urlString: "")
            )
        }
    }
}
