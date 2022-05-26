//
//  main.swift
//  ARC-HowItWorks
//
//  Created by Cristian Banarescu on 26.05.2022.
//

import Foundation

class ARCMemoryManager {
    deinit {
        print("ARCMemoryManager deallocated from Memory")
    }
}

var manager: ARCMemoryManager? = ARCMemoryManager() // ARC count = 1 (count of references to ARCMemoryManager)
var otherManager: ARCMemoryManager? = manager // ARC count = 2 (count of references to ARCMemoryManager)
var anotherManager: ARCMemoryManager? = manager // ARC count = 3 (count of references to ARCMemoryManager)

otherManager = nil // ARC count = 2 (count of references to ARCMemoryManager)
anotherManager = nil // ARC count = 1 (count of references to ARCMemoryManager)

manager = nil // ARC Count = 0  (count of references to ARCMemoryManager)
