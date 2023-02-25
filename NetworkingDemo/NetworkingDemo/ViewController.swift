//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 22.02.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPostsCollectionView()
        fetchPosts()
    }
}

// MARK: - Private

private extension ViewController {
    func setupPostsCollectionView() {
        let hostingVC = UIHostingController(rootView: PostsCollectionView(numberOfPosts: 30))
        
        guard let swiftuiView = hostingVC.view else {
            return
        }
        
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(hostingVC)
        view.addSubview(swiftuiView)
        
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        hostingVC.didMove(toParent: self)
    }
    
    func fetchPosts() {
        
    }
}
