//
//  Stack.swift
//  Stacks
//
//  Created by Cristian Banarescu on 18.02.2024.
//

import Foundation

struct Stack<Element: Equatable>: Equatable {
    private var storage: [Element] = []
    
    var isEmpty: Bool {
        peek() == nil
    }
    
    init(_ elements: [Element]) {
        self.storage = elements
    }
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        storage.popLast()
    }
    
    func peek() -> Element? {
        storage.last
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        storage.map { element in
            "\(element)"
        }.joined(separator: " ")
    }
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
