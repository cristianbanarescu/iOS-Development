//
//  CombineDemoApp.swift
//  CombineDemo
//
//  Created by Cristian Banarescu on 19.09.2025.
//

import SwiftUI
import Combine

@main
struct CombineDemoApp: App {
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification) // built-in publisher when using NotificationCenter
            .sink { notification in
                print(notification.userInfo!)
            } // .sink returns a 'subscription' that needs to be kept alive so that you receive events/values from publishers
            .store(in: &cancellables) // need to store the subscription to the publisher. if you don't store the subscription, you won't get values from it; Deallocation of the subscription (result from calling .sink on a publisher) will tear down the subscription stream.
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
