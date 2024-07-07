//
//  ContentView.swift
//  SwiftUI-MultipleDevices-macOS
//
//  Created by Cristian Banarescu on 02.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedAnimal: Animal
    
    var body: some View {
        NavigationSplitView {
            List(AnimalService.getAll(), id: \.name) { animal in
                VStack {
                    Text(animal.image)
                        .font(.system(size: 40))
                }
                .onTapGesture {
                    selectedAnimal = animal
                }
            }
        } detail: {
            DetailView(animal: selectedAnimal)
        }
    }
}

struct DetailView: View {
    let animal: Animal
    
    var body: some View {
        Text(animal.image)
            .font(.system(size: 100))
        Text(animal.description)
            .font(.system(size: 30))
    }
}

#Preview {
    ContentView(selectedAnimal: .placeholder)
}
