//
//  PostCell.swift
//  NetworkingDemo
//
//  Created by Cristian Banarescu on 25.02.2023.
//

import SwiftUI

struct PostCell: View {
    
    // MARK: - Properties
    
    private let title: String
    private let bodyString: String
    
    // MARK: - init
    
    init(title: String, bodyString: String) {
        self.title = title
        self.bodyString = bodyString
    }
    
    // MARK: - View

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Title:")
                Text(title)
            }
            HStack {
                Text("Body:")
                Text(bodyString)
            }
        }
        .font(Font.title3)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background(Color.mint)
        .cornerRadius(25)
    }
}

// MARK: - PreviewProvider

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(title: "test title", bodyString: "test body")
    }
}