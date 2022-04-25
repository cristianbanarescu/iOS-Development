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

