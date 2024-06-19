//
//  ContentView.swift
//  SwiftUI-DownloadImages
//
//  Created by Cristian Banarescu on 19.06.2024.
//

import SwiftUI

/// Displaying a downloaded image without using AsyncImage
struct ContentView: View {
    var body: some View {
        VStack {
            ImageWithURL(url: "https://images.nationalgeographic.org/image/upload/v1638882786/EducationHub/photos/sun-blasts-a-m66-flare.jpg", placeholderImage: "")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
