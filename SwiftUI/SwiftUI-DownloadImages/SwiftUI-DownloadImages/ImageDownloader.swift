//
//  ImageDownloader.swift
//  SwiftUI-DownloadImages
//
//  Created by Cristian Banarescu on 19.06.2024.
//

import Foundation

class ImageDownloader: ObservableObject {
    @Published var downloadedData: Data?
    
    func downloadImage(using urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data,
                  error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.downloadedData = data
            }
        }.resume()
    }
}
