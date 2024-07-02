//
//  DetailView.swift
//  SwiftUI-MultipleDevices
//
//  Created by Cristian Banarescu on 02.07.2024.
//

import SwiftUI

struct DetailView: View {
    let animal: Animal
    
    var body: some View {
        VStack {
            Text(animal.name)
            Text(animal.image)
                .font(.largeTitle)
            Text(animal.description)
        }
    }
}

#Preview {
    DetailView(animal: .placeholder)
}
