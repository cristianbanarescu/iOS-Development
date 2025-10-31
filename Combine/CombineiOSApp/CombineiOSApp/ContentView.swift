//
//  ContentView.swift
//  CombineiOSApp
//
//  Created by Cristian Banarescu on 31.10.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userService = UserService()
    
    var body: some View {
        VStack {
            Button("Fetch users") {
                userService.performFetchOfUsers()
            }
            Spacer()
            List(userService.namesFetched, id: \.self) { name in
                Text(name)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
