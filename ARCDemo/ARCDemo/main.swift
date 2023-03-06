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

// Comment above line >>> ARCMemoryManager won't be deallocated from memory because 'manager' is still holding a strong reference to it

class Laptop {
    let model: String
    var owner: Person?
    
    init(model: String, owner: Person? = nil) {
        self.model = model
        self.owner = owner
    }
    
    deinit {
        print("Laptop was deallocated from memory")
    }
}

class Person {
    let name: String
    var laptop: Laptop?
    
    init(name: String, laptop: Laptop? = nil) {
        self.name = name
        self.laptop = laptop
    }
    
    deinit {
        print("Person was deallocated from memory")
    }
}

var cristian: Person? = Person(name: "Cristian")
var macbook: Laptop? = Laptop(model: "PRO")

cristian?.laptop = macbook

// everything is fine, we don't need our references, we set the variables to 'nil'

cristian = nil
macbook = nil

// everything is ok up to this point >>> both Person and Laptop will be deallocated from memory

print("Done! Recreating objects\n")

// let's recreate the references

cristian = Person(name: "Cristian")
macbook = Laptop(model: "PRO")

// let's assign both the 'laptop' and the 'owner' properties

cristian?.laptop = macbook
macbook?.owner = cristian

// then let's set the variables to 'nil' again

cristian = nil
macbook = nil

// running the program, we can see that 'Person' and 'Laptop' were not deallocated from memory (the deinit print was not executed)
// this is because a reference cycle was created >>> 'Person' has a strong reference to 'Laptop' and 'Laptop' has a strong reference to 'Person'
// they both keep each other 'alive' in memory so they cannot be deallocated

// Solution:

// mark on of them as 'weak' or 'unowned'


class LaptopSolution {
    let model: String
    var owner: PersonSolution?
    
    init(model: String, owner: PersonSolution? = nil) {
        self.model = model
        self.owner = owner
    }
    
    deinit {
        print("LaptopSolution was deallocated from memory")
    }
}

class PersonSolution {
    let name: String
    weak var laptop: LaptopSolution? // or use 'unowned'
    
    init(name: String, laptop: LaptopSolution? = nil) {
        self.name = name
        self.laptop = laptop
    }
    
    deinit {
        print("PersonSolution was deallocated from memory")
    }
}

var cristianSolution: PersonSolution? = PersonSolution(name: "Cristian")
var macbookSolution: LaptopSolution? = LaptopSolution(model: "PRO")

cristianSolution?.laptop = macbookSolution
macbookSolution?.owner = cristianSolution

cristianSolution = nil
macbookSolution = nil
