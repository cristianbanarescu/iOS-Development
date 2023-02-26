//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 22.02.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var posts: [Post] = []
    private var networkService: NetworkServiceProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My posts"
        setupNavigationBarButtons()
        fetchPosts()
    }
    
    func config(with networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // TODO
    // try to refactor duplicate code
}

// MARK: - Private

private extension ViewController {
    func setupPostsCollectionView() {
        let hostingVC = UIHostingController(rootView: PostsCollectionView(posts: posts))
        
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
        networkService.fetchPosts { posts in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                self.posts = posts
                self.setupPostsCollectionView()
            }
        }
    }
    
    @objc func deletePosts() {
        networkService.deletePosts()
    }
    
    @objc func updatePost() {
        networkService.updatePost()
    }
    
    @objc func createPost() {
        networkService.createPost()
    }
    
    func setupNavigationBarButtons() {
        let deletePostsButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePosts))
        let updatePostsButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(updatePost))
        let createPostsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPost))
        
        navigationItem.setLeftBarButtonItems([updatePostsButton, deletePostsButton], animated: true)
        navigationItem.setRightBarButtonItems([createPostsButton], animated: true)
    }
}
