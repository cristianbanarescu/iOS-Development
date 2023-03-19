//
//  SafariView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 14.03.2023.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    var urlString: String
    
    // MARK: - UIViewControllerRepresentable
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        guard let url = URL(string: urlString) else {
            return SFSafariViewController(url: URL(string: "https://google.com")!)
        }
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
}
