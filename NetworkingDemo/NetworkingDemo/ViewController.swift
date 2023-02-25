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
        
        title = "My posts"
        setupNavigationBarButtons()
        fetchPosts()
    }
    
    // TODO
    // https://jsonplaceholder.typicode.com > needs to be in a central place (a String constant) and just use it everywhere
    // try to refactor duplicate code
    // use a dedicated object (maybe called 'NetworkService') that ONLY performs requests; inject this object here and use it; use a protocol for 'NetworkService'
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
        guard let urlRequest = urlRequest(with: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Couldn't fetch data. Error: \(error.localizedDescription)")
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
    
    func setupNavigationBarButtons() {
        let deletePostsButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePosts))
        let updatePostsButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(updatePostAction))
        let createPostsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPostAction))
        
        navigationItem.setLeftBarButtonItems([updatePostsButton, deletePostsButton], animated: true)
        navigationItem.setRightBarButtonItems([createPostsButton], animated: true)
    }
    
    @objc func deletePosts() {
        guard let urlRequest = urlRequest(with: "https://jsonplaceholder.typicode.com/posts/1", httpMethod: "DELETE") else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Couldn't perform delete request. Error: \(error.localizedDescription)")
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Response with status code: \(response.statusCode)")
                }
            }
            dataTask.resume()
        }
    }
    
    @objc func updatePostAction() {
        /*
         fetch('https://jsonplaceholder.typicode.com/posts/1', {
           method: 'PUT',
           body: JSON.stringify({
             id: 1,
             title: 'foo',
             body: 'bar',
             userId: 1,
           }),
           headers: {
             'Content-type': 'application/json; charset=UTF-8',
           },
         })
         */
    }
    
    @objc func createPostAction() {
        /*
         fetch('https://jsonplaceholder.typicode.com/posts', {
           method: 'POST',
           body: JSON.stringify({
             title: 'foo',
             body: 'bar',
             userId: 1,
           }),
           headers: {
             'Content-type': 'application/json; charset=UTF-8',
           },
         })
         */
    }
    
    func urlRequest(with urlString: String, httpMethod: String? = nil) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        return urlRequest
    }
    
}
