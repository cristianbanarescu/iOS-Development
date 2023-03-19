//
//  SafariViewControllerViewProvider.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 12.03.2023.
//

import SwiftUI

struct SafariViewControllerViewProvider: WebContentViewProvider {
    
    // MARK: - Properties

    var urlString: String
    
    var view: AnyView {
        AnyView(SafariView(urlString: urlString))
    }
}
