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

// MARK: - Tuples

// group multiple, different values into one
// values can be of any type inside a tuple

let principalAndInterestString = (100, "4.5%") // has type (Int, String)

let (principal, interestString) = principalAndInterestString

print("principal is: \(principal)")
print("interest is: \(interestString)")

let (justPrincipal, _) = principalAndInterestString // if you want to ignore a part of the tuple
print("Just the principal is: \(justPrincipal)")

// other way to access parts of the tuple
print(principalAndInterestString.0)
print(principalAndInterestString.1)

let secondPrincipalAndInterestString = (principal: 100, interestString: "4.5%") // named parts of the tuple

print("The principal is: \(secondPrincipalAndInterestString.principal)") // access the named parts
print("The interest is: \(secondPrincipalAndInterestString.interestString)")

// Tuples are useful if you want to know more info when you return something from a function
// Useful to return a Tuple with multiples values, maybe each value of different type
// ie when you call some web server method and it returns the error code and the error message (like 404, "Not found")

// MARK: - Optionals

// Either there is a value and you can unwrap it; either there isn't a value at all
// Swift optionals work for any type, unlike C or Objective C

let mayBeANumber = "12"

let convertedNumber = Int(mayBeANumber) // Optional Int > Int?; because conversion can fail ; not all Strings can be converted to Int

var myOptionalNumber: Int? = 100 // contains value 100
myOptionalNumber = nil // contains no value
myOptionalNumber = 88

var answer: String? // this is nil by default

// force unwrapping

print("My Optional number value is: \(myOptionalNumber!)") // use ! because I know for sure that myOptionalNumber has a value inside

// MARK: - Optional Binding

// use optional binding so that you can check if an optional contains a value and if so, make it available as a temporary variable or constant
// a.k.a bind a constant/variable with the value from inside an Optional, if there is a value inside

if let myOptionalNumberBinded = myOptionalNumber {
    print("there is a value: \(myOptionalNumberBinded)")
} else {
    print("There is no value here")
}

// following can be read as: if there is a value inside the myOptionalNumber, set a constant called myOptionalNumberBinded that contains the value from myOptionalNumber

if var mutableBindedNumber = myOptionalNumber { // manipulate the value binded from the Optional
    print("\(mutableBindedNumber)")
    mutableBindedNumber = 199
    print("\(mutableBindedNumber)")
} else {
    print("No value at all!")
}


// MARK: - Implicitly Unwrapped Optionals

// Optionals can be checked if they exist using an if statement and optional binding to see if the value exists or not.

// implicitly unwrapped = assumes that will have a value all the time (!)
// place an ! after the type

// useful when the value of the optional exists right after the optional is defined and assume that the Optional won't change its value afterwards

let possibleString: String? = "some string"
let forcedString: String = possibleString! // requires !

let implicitlyUnwrappedString: String! = "implicit"
let implicit: String = implicitlyUnwrappedString // does not require !

// implicitly unwrapping = give permission to the Optional to force-unwrap itself if needed
// implicitlyUnwrappedString is force-unwrapped because its value is put inside 'implicit' which has an explicit type of String

let someOtherString = implicitlyUnwrappedString // someOtherString has Optional type, just like any other optional

// MARK: - Error Handling

// Responding to errors your program may have during its execution (ie your program will 'throw' an error)
// You can propagate the error
// The caller of a function that throws error can catch the error and deal with it

func canThrow() throws {
    // this can throw errors
}

do {
    try canThrow()
    // if you're here, no error was thrown, execution of the program continued
} catch {
    // error was thrown and caught
}

enum MoneyError: Error {
    case noMoney
    case notEnoughMoney
    case investmentNotFound(String)
}

func investMoney() throws {
    //
}

do { // propagation
    try investMoney()
} catch MoneyError.noMoney {
    print("add money to your account")
} catch MoneyError.notEnoughMoney {
    print("please add more money")
} catch MoneyError.investmentNotFound(let investmentName) {
    print("\(investmentName) not found!")
}

// For more details, see https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html

// MARK: - Assertions and Preconditions

// Swift Standard Library
// Check something at runtime (These are Boolean checks)
// If your check is not 'ok', you won't execute the code below it
// If 'true' > everything is ok, code is further executed
// If 'false' > code stops > app terminated
// Assertions for Development code (only on Debug builds)
// Preconditions for Production code (both on Debug and Release builds)

let money = 10
//assert(money > 100, "You don't have enough money")

let age = 4

if age > 10 {
    print("old enough to invest")
} else if age > 5 {
    print("pretty close to investing")
} else {
    assertionFailure("you need to be older, of course")
}

// fatalError is also useful. It's better because the compiler always stops execution for a fatalError. In case you use 'unchecked' mode for the compiler, preconditions won't be checked, they will be defaulted to as being 'true'
