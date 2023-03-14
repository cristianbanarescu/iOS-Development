//
//  SafariView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 14.03.2023.
//

import SwiftUI
import SafariServices

// TODO fix this in order to actually load the SFSafariView from the controller

struct SafariView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let urlString: String
    
    func makeUIView(context: Context) -> UIView {
        SFSafariViewController(url: URL(string: urlString)!).view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
}
