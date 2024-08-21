//
//  WebService.swift
//  SwiftUI-AyncAwait
//
//  Created by Cristian Banarescu on 21.08.2024.
//

import Foundation

class WebService {
    // fetching the old way, using completion handlers and Result generic type
    static func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let todos = try? JSONDecoder().decode([Todo].self, from: data)
                completion(.success(todos ?? []))
            }
        }.resume()
    }
    
    // fetching the new way using async await
    static func fetchTodosAsync() async throws -> [Todo] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        let todos = try? JSONDecoder().decode([Todo].self, from: data)
        
        return todos ?? []
    }
    
    // fetch using the new way but based on old way; fetch using async + continuation in order to call existing completion handler code
    // good for usages when you want to create an async context (use async await) but you can't modify the existing method that uses completion handlers
    static func fetchTodosWithContinuation() async throws -> [Todo] {
        try! await withCheckedThrowingContinuation { continuation in // use a withCheckedContinuation if your async method doesn't throw
            fetchTodos { result in
                continuation.resume(with: result)
            }
        }
    }
}
