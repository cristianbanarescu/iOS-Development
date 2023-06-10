//
//  main.swift
//  TimeComplexityDemo
//
//  Created by Cristian Banarescu on 10.06.2023.
//

import Foundation

// MARK: - Constant time: O(1)

func constant() {
    print("Hello, World!")
}

func constant(array: [Int]) {
    if let first = array.first {
        print(first)
    } else {
        print("not the first element")
    }
}

// MARK: - Linear time: O(n)

func linear(array: [Int]) {
    for num in array {
        print(num)
    }
}

// MARK: - Quadratic time: O(n^2)

func quadratic(array: [Int]) {
    for i in 0..<array.count {
        for j in 0..<array.count {
            print(array[i] + array[j])
        }
    }
}

// MARK: - Logarithmic time: O(log n)

func logarithmic(n: Int) {
    var i = 1
    while i < n {
        print(i)
        i *= 2
    }
}


// MARK: - Exponential time: O(2^n)

func exponential(n: Int) -> Int {
    if n == 0 {
        return 1
    }
    return 2 * exponential(n: n-1)
}

class Simulator {
    enum ComplexityType: String, CustomStringConvertible {
        case constant
        case linear
        case logarithmic
        case quadratic
        case exponential
        
        var description: String {
            self.rawValue
        }
    }
    
    func calculateTime(for algorithmComplexityType: ComplexityType) {
        let testArray = [1,2,3,4,5]
        let n: Int = 50
        let startTime = CFAbsoluteTimeGetCurrent()
        print(Date())
        
        for _ in 1...10000 {
            switch algorithmComplexityType {
            case .constant:
                constant(array: testArray)
            case .linear:
                linear(array: testArray)
            case .logarithmic:
                logarithmic(n: n)
            case .quadratic:
                quadratic(array: testArray)
            case .exponential:
                _ = exponential(n: n)
            }
        }
        
        let endTime = CFAbsoluteTimeGetCurrent()
        let executionTime = endTime - startTime
        
        print("executionTime for \(algorithmComplexityType) is: \(executionTime)")
        print(Date())
    }
}

let simulator = Simulator()
//simulator.calculateTime(for: .constant)
//simulator.calculateTime(for: .linear)
//simulator.calculateTime(for: .logarithmic)
//simulator.calculateTime(for: .quadratic)
//simulator.calculateTime(for: .exponential)
