//
//  UserService.swift
//  CombineiOSApp
//
//  Created by Cristian Banarescu on 31.10.2025.
//

import Combine
import UIKit

@Observable // in order to make 'namesFetched' update the UI in the SwiftUI List
class UserService {
    private var cancellables = Set<AnyCancellable>()
    var namesFetched: [String] = []

    func performFetchOfUsers() {
        let urlString = "https://jsonplaceholder.typicode.com/users"

        URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!) // this is the publisher; below you use operators
            .tryMap { (data: Data, response: URLResponse) -> Data in // convert response and check status code
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [User].self, decoder: JSONDecoder()) // decode into User
            .replaceError(with: [User.default]) // if there's an error decoding data, just return this default user
            .receive(on: DispatchQueue.main) // force the next operator to schedule its work on the Main Thread
            .print()
            .breakpointOnError()
            .breakpoint()
            .handleEvents(receiveOutput: { print("fetched users: \($0)") })
            .sink(receiveCompletion: { completion in // receive values and completion; this is actually a subscriber
                switch completion {
                case .finished:
                    print("done fetching users")
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }, receiveValue: { [weak self] users in
                let names = users.map { $0.name }
                self?.namesFetched = names
            })
            .store(in: &cancellables)
    }
}
