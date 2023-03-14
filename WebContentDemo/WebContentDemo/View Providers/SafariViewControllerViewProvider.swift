//
//  SafariViewControllerViewProvider.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 12.03.2023.
//

import SwiftUI

// TODO 

struct SafariViewControllerViewProvider: WebContentViewProvider {    
    @State var urlString: String
    
    var view: AnyView {
        AnyView(SafariView(urlString: urlString))
    }
}
