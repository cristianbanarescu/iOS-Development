//
//  ViewController.swift
//  BinaryTree
//
//  Created by Cristian Banarescu on 19.02.2024.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tree = BinaryNode<Int>.createSomeIntTree()
        print(tree.traverseInOrder())
        print("new traversal: \n")
        
        print(tree.traversePreOrder())
        
        print("new traversal: \n")
        print(tree.traversePostOrder())

    }
}

