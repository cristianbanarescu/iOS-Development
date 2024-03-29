//
//  PostsCollectionView.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 25.02.2023.
//

import SwiftUI

struct PostsCollectionView: View {
    
    // MARK: - Properties
    
    private let posts: [Post]
    private let orientationChangedPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)

    @State var currentOrientation = UIDevice.current.orientation
    
    // MARK: - init
    
    init(posts: [Post]) {
        self.posts = posts
    }
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns(), spacing: 30) {
                ForEach(posts) { post in
                    PostCell(title: post.title, bodyString: post.body)
                }
            }
        }.onReceive(orientationChangedPublisher) { _ in
            self.currentOrientation = UIDevice.current.orientation
        }
    }
}

// MARK: - Private

private extension PostsCollectionView {
    func columns() -> [GridItem] {
        let numberOfColumns: Int = self.currentOrientation.isPortraitOrientation ? 2: 3
        
        var columns: [GridItem] = []
        
        for _ in 0..<numberOfColumns {
            columns.append(GridItem(.flexible()))
        }
        
        return columns
    }
}

// MARK: - PreviewProvider

struct PostsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        PostsCollectionView(posts: [])
    }
}
