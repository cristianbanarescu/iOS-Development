//
//  PostsCollectionView.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 25.02.2023.
//

import SwiftUI

struct PostsCollectionView: View {
    
    // MARK: - Properties
    
    private var numberOfPosts: Int
    
    // MARK: - init

    init(numberOfPosts: Int) {
        self.numberOfPosts = numberOfPosts
    }
    
    // MARK: - View
        
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns(), spacing: 30) {
                ForEach(0...numberOfPosts - 1, id: \.self) { _ in
                    PostCell(title: "x", bodyString: "y")
                }
            }
        }
    }
}

// MARK: - Private

private extension PostsCollectionView {
    func columns() -> [GridItem] {
        let numberOfColumns: Int = UIDevice().isPortraitOrientation ? 2: 3
        
        var columns: [GridItem] = []
        
        for _ in 0...numberOfColumns - 1 {
            columns.append(GridItem(.flexible()))
        }
        
        return columns
    }
}

// MARK: - PreviewProvider

struct PostsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        PostsCollectionView(numberOfPosts: 40)
    }
}
