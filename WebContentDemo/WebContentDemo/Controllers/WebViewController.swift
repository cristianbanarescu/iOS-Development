//
//  WebViewController.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 19.03.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Properties
    
    private var webView: WKWebView!
    private var urlString: String = ""
    
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
        
        title = url.host()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
    }
    
    // MARK: - Public
    
    func config(with urlString: String) {
        self.urlString = urlString
    }
}

// MARK: - Private

private extension WebViewController {
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
