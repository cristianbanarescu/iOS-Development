# WebContent Demo 

## Purpose 

- This project is an iOS application created using SwiftUI.
- Using URLSession, this application shows news data fetched from Algolia's API and displays it either using a `WKWebView` or a `SFSafariViewController`.

## Implementation 

- The data is fetched using a NetworkService [object](./WebContentDemo/Services/NetworkService.swift). It fetches news from API, either from the front page or it fetches 'stories'.
- Data is fetched onAppear of a NavigationView. The NavigationView shows a list of fetched news, split into 2 sections:
    - News displayed using a WKWebView.
    - News displayed using a SFSafariViewController
- In order to display data inside the WKWebView, the app uses a [WebViewSwiftUIController](./WebContentDemo/Views/WebViewSwiftUIController.swift) which is basically wrapping a UINavigationController inside a SwiftUI view, using the `UIViewControllerRepresentable` protocol.
- This project also uses `Key-Value Observing(KVO)` and `Delegates`: 
    - The title of the [WebViewController](./WebContentDemo/Controllers/WebViewController.swift) is changed based on when a WKWebView navigation finishes loading (WKNavigationDelegate's `didFinish navigation` method) or when the `estimatedProgress` of the WKWebView is updated.

## Data Sources

- This project contains data fetched from Algolia's API: https://hn.algolia.com/api 
- The project displays HackerNews (https://news.ycombinator.com/) data using the above mentioned API.

