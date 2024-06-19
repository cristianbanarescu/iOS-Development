//
//  ImageWithURL.swift
//  SwiftUI-DownloadImages
//
//  Created by Cristian Banarescu on 19.06.2024.
//

import SwiftUI

struct ImageWithURL: View {
    let url: String
    let placeholderImage: String
    @ObservedObject var imageDownloader = ImageDownloader()
    
    var body: some View {
        if let downloadedData = imageDownloader.downloadedData {
            return Image(uiImage: UIImage(data: downloadedData)!)
                .resizable().scaledToFit()
        } else {
            return Image("placeholder")
                .resizable().scaledToFit()
        }
    }
    
    init(url: String, placeholderImage: String = "default") {
        self.url = url
        self.placeholderImage = placeholderImage
        imageDownloader.downloadImage(using: url)
    }
}

#Preview {
    ImageWithURL(url: "https://images.nationalgeographic.org/image/upload/v1638882786/EducationHub/photos/sun-blasts-a-m66-flare.jpg", placeholderImage: "")
}
