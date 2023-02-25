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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
    }
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
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Couldn't fetch data from \(urlString). Error: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response with status code: \(response.statusCode)")
                }
                
                if let data = data {
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: data)
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.posts = posts
                            self.setupPostsCollectionView()
                            // TODO do not recreate whole collection view;
                            // just 'reload' the posts inside it 
                        }
                    } catch {
                        print("Could not decode Post from data, error: \(error.localizedDescription)")
                    }
                }
            }
            dataTask.resume()
        }
    }
}
