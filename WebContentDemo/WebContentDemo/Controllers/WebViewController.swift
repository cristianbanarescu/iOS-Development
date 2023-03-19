//
//  WebViewController.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 19.03.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Properties
    
    private var webView: WKWebView!
    private var urlString: String = ""
    private static var webViewObservedKeyPath: String = "estimatedProgress"
    
    // MARK: - Lifecycle

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        webView.load(URLRequest(url: url))
        
        title = "Loading: 0%"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        
        webView.addObserver(self, forKeyPath: Self.webViewObservedKeyPath, options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Self.webViewObservedKeyPath {
            title = String(format: "Loading: %.0f", Float(webView.estimatedProgress) * 100) + "%"
        }
    }
    
    // MARK: - Public
    
    func config(with urlString: String) {
        self.urlString = urlString
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = "Loaded: 100%"
    }
}

// MARK: - Private

private extension WebViewController {
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
