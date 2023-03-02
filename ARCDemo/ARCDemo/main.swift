//
//  main.swift
//  ARCDemo
//
//  Created by Cristian Banarescu on 02.03.2023.
//


import Foundation

class ARCMemoryManager {
    deinit {
        print("ARCMemoryManager deallocated from Memory")
    }
}

var manager: ARCMemoryManager? = ARCMemoryManager() // ARC count = 1 (1 reference to ARCMemoryManager)
var otherManager: ARCMemoryManager? = manager // ARC count = 2 (2 references to ARCMemoryManager)
var anotherManager: ARCMemoryManager? = manager // ARC count = 3 (3 references to ARCMemoryManager)

otherManager = nil // ARC count = 2 (2 references to ARCMemoryManager)
anotherManager = nil // ARC count = 1 (1 reference to ARCMemoryManager)
manager = nil // ARC Count = 0  (0 references to ARCMemoryManager) -> Only at this point ARCMemoryManager can be deallocated (because its reference count went to 0)
