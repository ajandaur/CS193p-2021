/// Constants and Variables

// multiple variables on a single line..
var x = 0.0, y = 0.0, z = 0.0

// Type Annotation

// use type annotation to be clear on the kind of values the constant or the variable can store --> "Declare a variable called welcomeMessage that's of type String"

var welcomeMessage: String

// Note that Swift usually infers the ype that is being used for a variable or constant

// Naming Constants and Variables

// You can't use: whitespace characters, mathematical symbols, arrows, private-use Unicode scalar values, or line- and box-drawing characters
// Also can't begin with a number

// You are allowed to change the value of an existing variable to another value of a compatible type
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

// As you known constants can't be changed once they are set..

// Printing Constants and Variables

print(friendlyWelcome)
//print() is a global function that prints one or more values to appropriate output
print("The current value of friendlyWelcome is \(friendlyWelcome)")

// The function print(_:separator:terminator:) have default values so they can be omitted and by default the function terminates the line it prints by adding a line break.

/// Comments

/* This is also a comment
 but is written over multiple lines
 like this */

// You can also do nested multiline comments

/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
This is the end of the first multiline comment. */

/// Semicolons

// Unlike infamous C++, we don't need to put semicolons after each statment.. but we can if we want to ;)
// Jk though, they are required if we want to write multiple separate statements on a single line
let cat = "😸"; print(cat)

/// Integers

// Integers can be signed (positive, zero, or negative) OR unsigned (positive or zero)

// Integer bounds

let minValue = UInt8.min //minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max // maxValue is equal to 255, and is of type UInt8

/// Floating-Point Numbers

// Now these are number with a fractional component, such as 3.14159, 0.1, and -273.15.
// We have two of these, we can have a Double or a Float

//Typealias are useful when you want to refer to an existing type by a name that is contextually more appropriate
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

//Error Handling
func canThrowAnError() throws {
    //this function may bor may not throw an error
}

do {
    try canThrowAnError()
    //no error was thrown
} catch {
    //an error was thrown
}

//Using assertions to debug

let age = -3
assert(age >= 0, "A person's age can't be less than zero.")
//the assertion fails because -3 is not >= 0

