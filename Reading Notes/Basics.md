# Constants and Variables
Here are multiple variables on a single line..
```swift
var x = 0.0, y = 0.0, z = 0.0
```

## Type Annotation
use type annotation to be clear on the kind of values the constant or the variable can store --> "Declare a variable called welcomeMessage that's of type String"

```swift 
var welcomeMessage: String
```
Note that Swift usually infers the ype that is being used for a variable or constant
## Naming Constants and Variables

- You can't use: whitespace characters, mathematical symbols, arrows, private-use Unicode scalar values, or line- and box-drawing characters
- Also can't begin with a number
- You are allowed to change the value of an existing variable to another value of a compatible type
```swift
var friendlyWelcome = "Hello!"

friendlyWelcome = "Bonjour!"
```
As you known constants can't be changed once they are set..
## Printing Constants and Variables
```swift
print(friendlyWelcome)
```
print() is a global function that prints one or more values to appropriate output
```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)")
```
The function print(_:separator:terminator:) have default values so they can be omitted and by default the function terminates the line it prints by adding a line break.
# Comments
```swift
/* This is also a comment

 but is written over multiple lines

 like this */
```
You can also do nested multiline comments
```swift
/* This is the start of the first multiline comment.

 /* This is the second, nested multiline comment. */

This is the end of the first multiline comment. */
```
# Semicolons
Unlike infamous C++, we don't need to put semicolons after each statment.. but we can if we want to ;)

Jk though, they are required if we want to write multiple separate statements on a single line
```swift
let cat = "😸"; print(cat)
```
 # Integers
Integers can be signed (positive, zero, or negative) OR unsigned (positive or zero)
## Integer bounds
```swift
let minValue = UInt8.min //minValue is equal to 0, and is of type UInt8

let maxValue = UInt8.max // maxValue is equal to 255, and is of type UInt8
```
# Floating-Point Numbers
Now these are number with a fractional component, such as 3.14159, 0.1, and -273.15.

We have two of these, we can have a Double or a Float
-   `Double` represents a 64-bit floating-point number.
-   `Float` represents a 32-bit floating-point number.

# Type Safety and Type Inference
Understand that Swift is a type-safe language so it wants us to be clear about clear about the types of values our code can work with

That is why Swift will type-check to avoid errors with different types of values.

But because of type inference, Swift wkll deduce the type of a particualr expression when it comples the code by just looking at the value you provide. Pretty neat stuff! 
```swift
let meaningOfLife = 42
 // meaningOfLife is inferred to be type Int 
 ```
But if you combine an int and a floating-pointe literal in an expression, Double will be inferred:
```swift
let anotherPi = 3 + 0.14159
// anotherPi is also inferred to be of type Double
```
# Numeric Literals
Integers can be written as either 
- A decimal number, with no prefix
- A binary number, with a 0b prefix
- An octal number, with a 0o prefix
- A hexadecimal number with a 0x prefix

All of these will have the decimal valueo of 17 though
```swift
let decimalInteger = 17
let binaryInteger = 0b10001 // 17 in binary notation
let octalInteger = 0o21 // 17 in octal notation
let hexadecimalInteger = 0x11 // 17 in hexadecimal notation
```
You can also have extra formatting for nuemric literals where they can be padded w/ extra zeros or have underscores 
```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```
# Numeric Type Conversion
Use the `Int` type for all general-purpose integer constants and variables in your code, even if they’re known to be nonnegative. Using the default integer type in everyday situations means that integer constants and variables are immediately interoperable in your code and will match the inferred type for integer literal values.

Use the other integer types only when you specifically need them for a task or for performance or necessary optimization.
## Integer Conversion
- An `Int8` constant or variable can store numbers between `-128` and `127`, whereas a `UInt8` constant or variable can store numbers between `0` and `255`.

A number that won't fit in a constant or variable of a sized integer type will come back as an error when the code is complied:
```swift
let cannotBeNegative: UInt8 = -1
// UInt8 can't store negative numbers, and so this will report an error
let tooBig: Int8 = Int8.max + 1
// Int8 can't store a number larger than its maximum value,
// and so this will also report an error
```
For case-by-case basis, you need to convert one specific number type to another. To do so, initialize a new number of the desired type with the existing value:
```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```
`SomeType(ofInitialValue)` is the default way to call the initializer of a Swift type and pass in an initial value. Behind the scenes, `UInt16` has an initializer that accepts a `UInt8` value, and so this initializer is used to make a new `UInt16` from an existing `UInt8`. You can’t pass in _any_ type here, however—it has to be a type for which `UInt16` provides an initializer. Extending existing types to provide initializers that accept new types (including your own type definitions) is covered in [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html).
## Integer and Floating-Point Conversion
**Conversions between integer and floating-point numeric types must be made explicit:**
```swift
let three = 3 
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + poointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
```
Without the conversion, the addition would not be allowed.

**Floating-point values are always truncated when used to initialize a new integer value in this way. This means that `4.75` becomes `4`, and `-3.9` becomes `-3`.**
# Typealias
Typealias are useful when you want to refer to an existing type by a name that is contextually more appropriate
```swift
typealias AudioSample = UInt16
```
Once you defint it, you can use the alias anywhere you might have used the original name:
```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound is now 0
```
# Booleans
Swift has a basic _Boolean_ type, called `Bool`. Boolean values are referred to as _logical_, because they can only ever be true or false. Swift provides two Boolean constant values, `true` and `false`:
```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```
# Tuples 
_Tuples_ group multiple values into a single compound value. **The values within a tuple can be of any type and don’t have to be of the same type as each other.**

In this example, `(404, "Not Found")` is a tuple that describes an _HTTP status code_. An HTTP status code is a special value returned by a web server whenever you request a web page. A status code of `404 Not Found` is returned if you request a webpage that doesn’t exist.
```swift
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")
```
You can decompose a tuple's contents into separate constants or variables: 
```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
```
But if you only need some of the tuples values, ignore parts of the tuple with an "__" when you decompose: 
```swift
let (justTheStatusCode, __) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"
```
You can also access individual elemtn values in a tuple using index numbers starting at 0:
```swift
print("The status code is \(http404.Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status code is Not Found"
```
Tuples are particularly useful as the return values of functions. A function that tries to retrieve a web page might return the `(Int, String)` tuple type to describe the success or failure of the page retrieval. By returning a tuple with two distinct values, each of a different type, the function provides more useful information about its outcome than if it could only return a single value of a single type. For more information, see [Functions with Multiple Return Values](https://docs.swift.org/swift-book/LanguageGuide/Functions.html#ID164).
# Optionals
You use _optionals_ in situations where a value may be absent. An optional represents two possibilities: Either there _is_ a value, and you can unwrap the optional to access that value, or there _isn’t_ a value at all.

Example of optionals being used to cope with the absence of a value:
```swift
let possibl;eNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"
```
Because the initializer might fail, it returns an _optional_ `Int`, rather than an `Int`. An optional `Int` is written as `Int?`, not `Int`. The question mark indicates that the value it contains is optional, meaning that it might contain _some_ `Int` value, or it might contain _no value at all_. (It can’t contain anything else, such as a `Bool`value or a `String` value. It’s either an `Int`, or it’s nothing at all.)
## nil
You set an optional variable to a valueless state by assigning it the special value `nil`:
```swift
var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value
```
If you define an optional variable without providing a default value, the variable is automatically set to `nil` for you:
```swift
var surveyAnswer: String
// surveyAnswer is automatically set to nil
```
## If Statements and Forced Unwrapping
You can use an `if` statement to find out whether an optional contains a value by comparing the optional against `nil`. You perform this comparison with the “equal to” operator (`==`) or the “not equal to” operator (`!=`).
If an optional has a value, it’s considered to be “not equal to” `nil`:
```swift
if convertedNumber != nil {
 print("convertedNumber contains some integer value.")
 }
// Prints "convertedNumber contains some integer value."
```
Once you’re sure that the optional _does_ contain a value, you can access its underlying value by adding an exclamation point (`!`) to the end of the optional’s name. The exclamation point effectively says, “I know that this optional definitely has a value; please use it.” This is known as _forced unwrapping_ of the optional’s value:
```swift
if convertedNumber != nil {
print("convertedNumber has an integer value of \(convertedNumber!).")
}
// Prints "convertedNumber contains some integer value."
```
## Optional Binding
You use _optional binding_ to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with `if` and `while` statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action. `if` and `while` statements are described in more detail in [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html).
Write an optional binding for an `if` statement as follows:
```swift
if let constantName = someOptional {
	statements
}
```
You can include as many optional bindings and Boolean conditions in a single `if` statement as you need to, separated by commas. If any of the values in the optional bindings are `nil` or any Boolean condition evaluates to `false`, the whole `if`statement’s condition is considered to be `false`. The following `if` statements are equivalent:
```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
if let secondNumber = Int("42") {
if firstNumber < secondNumber && secondNumber < 100 {
print("\(firstNumber) < \(secondNumber) < 100")
		}
	}
}
// Prints "4 < 42 < 100"
```
## Implicity Unwrapped Optionals
As described above, optionals indicate that a constant or variable is allowed to have “no value”. Optionals can be checked with an `if` statement to see if a value exists, and can be conditionally unwrapped with optional binding to access the optional’s value if it does exist.

Sometimes it’s clear from a program’s structure that an optional will _always_ have a value, after that value is first set. In these cases, it’s useful to remove the need to check and unwrap the optional’s value every time it’s accessed, because it can be safely assumed to have a value all of the time.

These kinds of optionals are defined as _implicitly unwrapped optionals_. You write an implicitly unwrapped optional by placing an exclamation point (`String!`) rather than a question mark (`String?`) after the type that you want to make optional. Rather than placing an exclamation point after the optional’s name when you use it, you place an exclamation point after the optional’s type when you declare it.

Implicitly unwrapped optionals are useful when an optional’s value is confirmed to exist immediately after the optional is first defined and can definitely be assumed to exist at every point thereafter. The primary use of implicitly unwrapped optionals in Swift is during class initialization, as described in [Unowned References and Implicitly Unwrapped Optional Properties](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html#ID55).

An implicitly unwrapped optional is a normal optional behind the scenes, but can also be used like a non-optional value, without the need to unwrap the optional value each time it’s accessed. The following example shows the difference in behavior between an optional string and an implicitly unwrapped optional string when accessing their wrapped value as an explicit `String`:
```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation point
```
You can think of an implicitly unwrapped optional as giving permission for the optional to be force-unwrapped if needed. When you use an implicitly unwrapped optional value, Swift first tries to use it as an ordinary optional value; if it can’t be used as an optional, Swift force-unwraps the value. In the code above, the optional value `assumedString` is force-unwrapped before assigning its value to `implicitString` because `implicitString` has an explicit, non-optional type of `String`. In code below, `optionalString` doesn’t have an explicit type so it’s an ordinary optional.
```swift
let optionalString = assumedString
// the type of optionalString is "String?" and assumedString isn't force-unwrapped
```
If an implicitly unwrapped optional is `nil` and you try to access its wrapped value, you’ll trigger a runtime error. The result is exactly the same as if you place an exclamation point after a normal optional that doesn’t contain a value.

You can check whether an implicitly unwrapped optional is `nil`the same way you check a normal optional:
```swift
if assumedString != nil {
	print(assumeedString!)
	}
// Prints "An implicitly unwrapped optional string."
```
You can also use an implicitly unwrapped optional with optional binding, to check and unwrap its value in a single statement:
```swift
if let definiteString = assumedString {
	print(definiteString)
}
4.  // Prints "An implicitly unwrapped optional string."
```
# Error Handling
You use _error handling_ to respond to error conditions your program may encounter during execution.

In contrast to optionals, which can use the presence or absence of a value to communicate success or failure of a function, error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program.

When a function encounters an error condition, it _throws_ an error. That function’s caller can then _catch_ the error and respond appropriately.
```swift
func canThrowAnError() throws {
 //this function may bor may not throw an error
}
```
  A function indicates that it can throw an error by including the `throws` keyword in its declaration. When you call a function that can throw an error, you prepend the `try` keyword to the expression.

Swift automatically propagates errors out of their current scope until they’re handled by a `catch` clause.
```swift
do {
	try canThrowAnError()
	// no error was thrown
} catch {
	// an error was thrown
}
```
A `do` statement creates a new containing scope, which allows errors to be propagated to one or more `catch` clauses.
# Error Handling

# Assertions and Preconditions
_Assertions_ and _preconditions_ are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any further code. If the Boolean condition in the assertion or precondition evaluates to `true`, code execution continues as usual. If the condition evaluates to `false`, the current state of the program is invalid; code execution ends, and your app is terminated.

You use assertions and preconditions to express the assumptions you make and the expectations you have while coding, so you can include them as part of your code. Assertions help you find mistakes and incorrect assumptions during development, and preconditions help you detect issues in production.

In addition to verifying your expectations at runtime, assertions and preconditions also become a useful form of documentation within the code. Unlike the error conditions discussed in [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID515) above, assertions and preconditions aren’t used for recoverable or expected errors. Because a failed assertion or precondition indicates an invalid program state, there’s no way to catch a failed assertion.

Using assertions and preconditions isn’t a substitute for designing your code in such a way that invalid conditions are unlikely to arise. However, using them to enforce valid data and state causes your app to terminate more predictably if an invalid state occurs, and helps make the problem easier to debug. Stopping execution as soon as an invalid state is detected also helps limit the damage caused by that invalid state.

The difference between assertions and preconditions is in when they’re checked: **Assertions are checked only in debug builds, but preconditions are checked in both debug and production builds.** In production builds, the condition inside an assertion isn’t evaluated. This means you can use as many assertions as you want during your development process, without impacting performance in production.

## Debugging with Assertions

You write an assertion by calling the [`assert(_:_:file:line:)`](https://developer.apple.com/documentation/swift/1541112-assert)function from the Swift standard library. You pass this function an expression that evaluates to `true` or `false` and a message to display if the result of the condition is `false`. For example:
```swift
let age = -3
assert(age >=0, "A person's age can't be less than zero.")
// This assertion fails because -3 isn't >=0
```
In this example, code execution continues if `age >= 0` evaluates to `true`, that is, if the value of `age` is nonnegative. If the value of `age` is negative, as in the code above, then `age >= 0` evaluates to `false`, and the assertion fails, terminating the application.
## Enforcing Preconditions
Use a precondition whenever a condition has the potential to be false, but must _definitely_ be true for your code to continue execution. For example, use a precondition to check that a subscript isn’t out of bounds, or to check that a function has been passed a valid value.

You write a precondition by calling the [`precondition(_:_:file:line:)`](https://developer.apple.com/documentation/swift/1540960-precondition) function. You pass this function an expression that evaluates to `true` or `false` and a message to display if the result of the condition is `false`. For example:
```swift
// In the implementation of a subscript...
precondition(index > 0, "Index must be greater than zero.")
```
You can also call the [`preconditionFailure(_:file:line:)`](https://developer.apple.com/documentation/swift/1539374-preconditionfailure)function to indicate that a failure has occurred—for example, if the default case of a switch was taken, but all valid input data should have been handled by one of the switch’s other cases.