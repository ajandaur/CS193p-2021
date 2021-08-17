//assignment operator
let b = 10
var a = 5
a = b

let (x,y) = (1,2)

// x = y doesn't return anything

//arithetmetic operators
let three = 3
let minusThree = -three
let plusThree = -minusThree

let minusSix = -6
let alsoMinusSix = +minusSix
//the urary plus operator simply returns the value it operates on without any changes

//tuple are compared from left to right, one value at a time, unil the comparison finds two values that aren't equal
(1, "zebra") < (2, "apple")

// < operator can't be applied to Bool values

//Ternary Conditional Operator
let contentHeader = 40
let hasHeader = true
let rowHeight = contentHeader + (hasHeader ? 50 : 20)
//rowHeight is equal to 90

//Nil-Coalescing Operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil

let defaultColorName = "red"
var userDefinedColorName: String? //defaults to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName
//userDefiendColorName is nil, so colorNameToUse is set to default of "red"
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
//userDefinedColorName is not nil, so colorNameToUse is set to "green"


//Range Operators
for index in 1...5 {
    print("\(index) times 5 is \(index*5)")
}

//half-open range operator
let names = ["Anna", "Alex","Brian","Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i+1) is called \(names[i])")
}

//one-sided ranges
for name in names[2...] {
    print(name)
}

//Logical operators
//careful choice of BooLean constant and variable names help keeps code readable and concise
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}


