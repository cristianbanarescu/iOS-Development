//
//  ContentView.swift
//  SwiftUI-MultipleDevices-WatchOS Watch App
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
                    AnimalCell(animal: animal)
                }
            }
            .listStyle(CarouselListStyle())
        }
    }
}

#Preview {
    ContentView()
}

struct AnimalCell: View {
    let animal: Animal
    
    var body: some View {
        VStack(alignment: .center) {
            Text(animal.image)
                .font(.title2)
            Text(animal.name)
        }
        .frame(maxWidth: .infinity)
    }
}
