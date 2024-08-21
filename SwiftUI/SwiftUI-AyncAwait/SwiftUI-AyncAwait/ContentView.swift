//
//  ContentView.swift
//  SwiftUI-AyncAwait
//
//  Created by Cristian Banarescu on 20.08.2024.
//

import SwiftUI

/*
 
 Async Await and Structured Concurrency:
 
 - usage of async await and Structured Concurrency
 - interoperability of async await with classic completionHandler based code
 - use https://jsonplaceholder.typicode.com/todos in order to perform an async call using URLSession
 - populate the UI with data from https://jsonplaceholder.typicode.com/todos
 - completionHandler vs async await for request to fetch TODOS from https://jsonplaceholder.typicode.com/todos
 - call method with completionHandler from async context (via continuations)
 - YT playlist with more useful explanations: https://www.youtube.com/watch?v=p6q1RmYUsNU&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM
 
 */

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
//        .onAppear {
//            print("fetching the old way")
//            WebService.fetchTodos { result in
//                switch result {
//                case .success(let todos):
//                    print(todos)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
        .task { // perform async stuff before view appears
            let todos = try? await WebService.fetchTodosAsync()
            print("fetching the NEW way")
            print(todos ?? [])
        }
    }
}

#Preview {
    ContentView()
}
