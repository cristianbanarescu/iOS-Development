//
//  ContentView.swift
//  SwiftUI-MultipleDevices
//
//  Created by Cristian Banarescu on 02.07.2024.
//

import SwiftUI

struct ContentView: View {
    private let animals = AnimalService.getAll()
    
    var body: some View {
        NavigationStack {
            List(animals, id: \.name) { animal in
                NavigationLink {
                    DetailView(animal: animal)
                } label: {
                    HStack {
                        Text(animal.name)
                        Text(animal.image)
                            .font(.largeTitle)
                    }
                }

            }
            .navigationTitle("Animals")
        }
    }
}

#Preview {
    ContentView()
}
