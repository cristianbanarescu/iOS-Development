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
//var myVar: String = "9"

//var default = 9 // You can't directly name a variable/constant using direct Swift keywords

// If you do want to name it using a Swift keyword, surround your variable/constant name with backticks (`)
var `default` = 9

var myVariable = 9
myVariable = 10 // this is OK, because myVariable is a variable, you can change its value after it was set

let myConstant = 10
//myConstant = 11 // this is NOK, because myConstant is a constant, you cannot change its value after it was set

// MARK: - Printing Constants and Variables

print(myConstant) // use separator and terminator parameters from the print global function to 'alter' the print

print("the value of my constant is: \(myConstant)") // \() is called String interpolation
// uses the name of the variable/constant/etc inside the longer String and makes Swift replace that with the actual value behind it
// this will print: the value of my constant is: 10

// MARK: - Comments

// This is a comment

/*
 This is a multiline comment
 */

/*
 This is a multiline
 /* comment nested inside a multiline comment */
 */

// MARK: - Integers, Int, UInt

/// Integers = whole numbers without floating component
/// (Not only Integers) Can be:
///     - signed (positive, zero, negative); ALL NUMBERS (- AND +)
///     - unsigned (positive, zero); WITHOUT NEGATIVE NUMBERS
/// Swift has signed and unsigned integers in 8, 16, 32, 64 bit forms
/// ie UInt8 - unsigned integers in 8 bit form
/// ie Int32 - signed integers in 32 bit form

let minUInt8 = UInt8.min
let maxUInt8 = UInt8.max

/// Use Int by default, even if you know for sure you have only nonnegative numbers. Int is good for code interoperability, matches type inference, etc.
/// Int is either Int32 or Int64 based on the platform's word-size: 32-bit platform > Int32 ... 64 bit-platform > Int64
/// Same considerations for UInt, but UInt is UNSIGNED (includes only positive numbers and 0)

//let unsignedNumber: UInt = -9 // error because UInt only stores positives and zero

// MARK: - Floating-point numbers

/// Numbers with a fractional component (23.45, -129.3, etc)
/// Much larger numbers than those included in Int
/// 2 types: Double and Float
/// Double > 64-bit numbers (preferred by default, it has greater precision than Float: at least 15 decimal digits vs 6 in Float )
/// Float > 32-bit numbers

// MARK: - Type Safety & Type Inference

/// Swift is a type-safe language > it 'makes' you be clear about the types you work with.
/// If you need a String, you can't later pass an Int
/// Swift performs type checking when compiling your code and finds any 'errors' related to types being used wrong
/// You don't need tot specify the type for each variable or constant you use. Swift deduces(inferes) the type based on the value of the variable/constant at compile time.

let numberOfApples = 3
// Int is inferred automatically

let pi = 3.14
// Double is inferred automatically. Swift always chooses Double over Float by default

let pies = 3 + 3.14
// Double is inferred automatically

// MARK: - Numeric Literals

/// Literal = value that appears directly in source code, like 23, 10, etc

/// Integer Literals
let decimal = 17 // 17 in decimal notation
let binary = 0b10001 // 17 in binary notation
let octal = 0o21 // 17 in octal notation
let hexadecimal = 0x11 // 17 in hexadecimal notation

/// Floating-point literals can be decimal or hexadecimal
/// They must have a number (or hexadecimal number) on both sides of the decimal point (left and right of the decimal point)
/// Decimal floats can have OPTIONAL exponent (e or E); base number will be multiplied by 10^exp
/// Hexadecimal MUST have an exponent(p or P); base number will be multiplied by 2^exp

let number = 1.25e2 // 1.25 * 10^2 = 1.25 * 100 = 125.0
let secondNumber = 1.25e-2 // 1.25 * 10^-2 = 0.0125

let hexaNumber = 0xFp2 // 15(F) * 2^2 = 60.0
let secondHexaNumber = 0xFp-2 // 15 * 2^-2 = 3.75

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0 // (12(C) * 16^0) + (3 * 16^-1 * 2^0) = 12 + 0.1875 = 12.1875

/// Numeric Literals can have formatting to be read easier

let paddedFloatWithZeros = 000123.456
let oneMillion = 1_000_000
let aLittleOverOneMillion = 1_000_000.000_000_1

// MARK: - Numeric Type Conversion

/// Use Int by default
/// Use other Integer types explicitly when you need performance, optimizations and size data
/// Int8 values: -128 > 127
/// UInt8 values: 0 > 255

//let cantBeNegative: UInt8 = -10 // UInt8 stores only values from 0 > 255
//let isTooBig: Int8 = Int8.max + 1 // Int8 can't store a value that is bigger than its max

let oneThousand: UInt16 = 1_000
let one: UInt8 = 1
let oneThousandAndOne = oneThousand + UInt16(one) // convert UInt8 into UInt16 by using UInt16(UInt8_value)

let pointFourteen = 0.14
let three = 3

let piAddition = Double(three) + pointFourteen // without converting 'three' to Double, the addition won't be possible; the values were not of the same type

print(3 + 0.14) // this works without any type conversion because these 2 are Numeric Literals. The compiler inferres their type when they are evaluated

// MARK: - Type Aliases

/// Use 'typealias' keyword
/// You give another name to an existing type
/// Useful when you want to use other naming that is more appropriate than using an existing type's name
 
typealias AudioSample = UInt16

// instead of this
let sample: UInt16 = 10

// you can do this
let audioSample: AudioSample = 10

// you can use the same 'stuff' that the aliased type had
// like this:
let minimumAudioSample = AudioSample.min // this actually will call UInt16.min

// MARK: - Booleans

let waterIsGood = true // infered type > Bool

// useful when used in conditional statements


