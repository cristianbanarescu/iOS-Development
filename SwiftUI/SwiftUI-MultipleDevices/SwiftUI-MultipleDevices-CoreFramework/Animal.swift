//
//  Animal.swift
//  SwiftUI-MultipleDevices
//
//  Created by Cristian Banarescu on 02.07.2024.
//

import Foundation

struct Animal: Hashable {
    let name: String
    let description: String
    let image: String
}

extension Animal {
    static var placeholder: Animal {
        Animal(name: "", description: "", image: "")
    }
}
