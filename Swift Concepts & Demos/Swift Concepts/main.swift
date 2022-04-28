//
//  main.swift
//  Swift Concepts
//
//  Created by Cristian Banarescu on 06.04.2022.
//

import Foundation

// MARK: - Constants and Variables

/// associate/put together a name with/and a value of a particular type
/// constants(let) - the value of them can't be changed once they are set
/// variables(var) - can have their value changed after they are set
/// by default, always use constants if your values won't change

let maximumNumberOfLoginAttempts = 10 // constant
var currentLoginAttempt = 0 // variable
var x = 0.0, y = 0.0, z = 0.0 // anothery way of declaring variables; doing it on the same line

// MARK: - Type annotations

/// you can provide a type for a variable or constant to make sure that the values you provide for storing will be of an exact type
/// type can be inferred from a variable/constant when you declare it and also give it an inital value, without explicitly writing the type

var welcomeMessage: String // declare a variable of type 'String'; can store any String value
welcomeMessage = "Hello"

var red, green, blue: Double // use only 1 line to declare 3 constants with the same type

// MARK: - Naming Constants and Variables

/// Constans and variables can contain almost any character in their name.
/// There are some restrictions though. They can't:
///   - begin with a number
///   - contain whitespace characters, mathematical symbols, arrows, private-use Unicode scalar values, or line- and box-drawing characters.
///
/// For more on naming restrictions, please see Naming section from: https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html

let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

/// You can't use the same name for a variable/constant and just change its type
/// Nor you can declare it again with the same name
var myVar: Int = 10
var myVar: String = "9"

var default = 9 // You can't directly name a variable/constant using direct Swift keywords

// If you do want to name it using a Swift keyword, surround your variable/constant name with backticks (`)
var `default` = 9

var myVariable = 9
myVariable = 10 // this is OK, because myVariable is a variable, you can change its value after it was set

let myConstant = 10
myConstant = 11 // this is NOK, because myConstant is a constant, you cannot change its value after it was set

// MARK: - Printing Constants and Variables

print(myConstant) // use separator and terminator parameters from the print global function to 'alter' the print

print("the value of my constant is: \(myConstant)") // \() is called String interpolation
// uses the name of the variable/constant/etc inside the longer String and makes Swift replace that with the actual value behind it
// this will print: the value of my constant is: 10


