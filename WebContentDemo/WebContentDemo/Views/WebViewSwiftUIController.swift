//
//  WebViewSwiftUIController.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 14.03.2023.
//

import SwiftUI

struct WebViewSwiftUIController: UIViewControllerRepresentable {
    
    // MARK: - Properties

    var urlString: String
    
    // MARK: - UIViewControllerRepresentable
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let webViewController = WebViewController()
        webViewController.config(with: urlString)
        return UINavigationController(rootViewController: webViewController)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
