#  Networking Demo

## Purpose

- This project showcases how to perform network requests using URLSession and Alamofire
- It also showcases the usage of the Codable protocol so that objects can be both decoded/coded from/to network requests

## Data Sources

- This project uses the JSON Placeholder `posts` API from https://jsonplaceholder.typicode.com/ in order to perform network requests

## Implementation 

- The UI elements of this demo project were created using SwiftUI - check the [Views](./NetworkingDemo/Views/) folder for more details.
- Network requests are performed based on implementations of the `NetworkServiceProtocol` protocol. See [NetworkService.swift](./NetworkingDemo/Services/NetworkService.swift), [AlamofireNetworkService.swift](./NetworkingDemo/Services/AlamofireNetworkService.swift) and [URLSessionNetworkService.swift](./NetworkingDemo/Services/URLSessionNetworkService.swift) for more details.
- The `Post` object is used together with the `Codable` protocol in order to decode and encode model objects and perform requests inside the app. See [Post.swift](./NetworkingDemo/Model/Post.swift) for more details.