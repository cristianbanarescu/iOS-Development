//
//  AnimalService.swift
//  SwiftUI-MultipleDevices
//
//  Created by Cristian Banarescu on 02.07.2024.
//

import Foundation

class AnimalService: NSObject {
    static func getAll() -> [Animal] {
        [
            Animal(name: "Lion", description: "The king of the jungle", image: "🦁"),
            Animal(name: "Tiger", description: "A large wild cat with stripes", image: "🐅"),
            Animal(name: "Elephant", description: "The largest land animal", image: "🐘"),
            Animal(name: "Monkey", description: "A playful and intelligent primate", image: "🐒"),
            Animal(name: "Giraffe", description: "A tall animal with a long neck", image: "🦒"),
            Animal(name: "Zebra", description: "A horse-like animal with black and white stripes", image: "🦓"),
            Animal(name: "Panda", description: "A bear native to China, known for its black and white fur", image: "🐼"),
            Animal(name: "Kangaroo", description: "A marsupial from Australia known for its jumping ability", image: "🦘"),
            Animal(name: "Penguin", description: "A flightless bird that lives in the Southern Hemisphere", image: "🐧"),
            Animal(name: "Frog", description: "An amphibian known for its jumping ability and croaking sound", image: "🐸")
        ]
    }
}
