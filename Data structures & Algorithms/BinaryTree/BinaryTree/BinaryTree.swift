//
//  BinaryTree.swift
//  BinaryTree
//
//  Created by Cristian Banarescu on 19.02.2024.
//

import Foundation

class BinaryNode<Element> {
    var value: Element
    var leftChild: BinaryNode?
    var rightChild: BinaryNode?
    
    init(value: Element) {
        self.value = value
    }
    
    static func createSomeIntTree() -> BinaryNode<Int> {
        let root = BinaryNode<Int>(value: 7)
        
        let leftChild = BinaryNode<Int>(value: 1)
        let rightChild = BinaryNode<Int>(value: 9)
        
        root.leftChild = leftChild
        root.rightChild = rightChild
        
        leftChild.leftChild = BinaryNode<Int>(value: 0)
        leftChild.rightChild = BinaryNode<Int>(value: 5)
        
        rightChild.leftChild = BinaryNode<Int>(value: 8)
        
        return root
    }
    
    func traverseInOrder() {
        leftChild?.traverseInOrder()
        print(value)
        rightChild?.traverseInOrder()
    }
    
    func traversePreOrder() {
        print(value)
        leftChild?.traversePreOrder()
        rightChild?.traversePreOrder()
    }
    
    func traversePostOrder() {
        leftChild?.traversePostOrder()
        rightChild?.traversePostOrder()
        print(value)
    }
}
