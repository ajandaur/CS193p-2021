# String Literals 
Use string literals as an initial value for a constant or variable:
```swift
let someString = "Some string literal value"
```
## Multiline String Literals
```swift
let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
7.  """
```
## Special Characters in String Literals
String literals can include the following special characters:

-   The escaped special characters `\0` (null character), `\\` (backslash), `\t` (horizontal tab), `\n` (line feed), `\r` (carriage return), `\"` (double quotation mark) and `\'` (single quotation mark)
-   An arbitrary Unicode scalar value, written as `\u{`_n_`}`, where _n_ is a 1–8 digit hexadecimal number (Unicode is discussed in [Unicode](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html#ID293) below)
# Initializing an Empty String
```swift
var emptyString = ""
var anotherOne = String()
// both strings are empty and equivalent to each other
```
- to check if it is empty, use `isEmpty` property
# String Mutability
- Use let or var to indicate whether a string is mutable:
```swift
var variableString = "Horse"
variableString += " and carriage"
// variableString is now "Horse and carriage"

let constantString = "Highlander"
constantString += " and another Highlander"
// this reports a compile-time error - a constant string cannot be modified
```
# Strings Are Value Types
Swift’s `String` type is a _value type_. If you create a new `String` value, that `String` value is _copied_ when it’s passed to a function or method, or when it’s assigned to a constant or variable. In each case, a new copy of the existing `String` value is created, and the new copy is passed or assigned, not the original version. Value types are described in [Structures and Enumerations Are Value Types](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html#ID88).
# Working with Characters
Iterate through the individual `Character` values for a `String` by iterating over the string with a `for`-`in` loop:
```swift
for chracter in "Dog!🐶" {
	print(character)
}
```
`String` values can be constructed by passing an array of `Character`values as an argument to its initializer:
```swift
let catCharacters: [Character] = ["C","a","t","!","🐱"]
let catString = String(catCharacter)
print(catString)
```
# Concatenating Strings and Characters
- You can also append a `String` value to an existing `String` variable with the addition assignment operator (`+=`)
- You can append a `Character` value to a `String` variable with the `String` type’s `append()` method
- But you CANNOT append a String or Character to an existing Character variable
# String Interpolation
```swift
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"
```
In the example above, the value of `multiplier` is inserted into a string literal as `\(multiplier)`. This placeholder is replaced with the actual value of `multiplier` when the string interpolation is evaluated to create an actual string.

The value of `multiplier` is also part of a larger expression later in the string. This expression calculates the value of `Double(multiplier) * 2.5` and inserts the result (`7.5`) into the string. In this case, the expression is written as `\(Double(multiplier) * 2.5)` when it’s included inside the string literal.
# Unicode
## Unicode Scalar Values
Behind the scenes, Swift’s native `String` type is built from _Unicode scalar values_. A Unicode scalar value is a unique 21-bit number for a character or modifier, such as `U+0061` for `LATIN SMALL LETTER A` (`"a"`), or `U+1F425` for `FRONT-FACING BABY CHICK` (`"🐥"`).

Note that not all 21-bit Unicode scalar values are assigned to a character—some scalars are reserved for future assignment or for use in UTF-16 encoding. Scalar values that have been assigned to a character typically also have a name, such as `LATIN SMALL LETTER A` and `FRONT-FACING BABY CHICK` in the examples above.
# Counting Characters
To retrieve a count of the `Character` values in a string, use the `count` property of the string:
```swift
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// Prints "unusualMenagerie has 40 characters"
```
# Accessing and Modifying a String
You access and modify a string through its methods and properties, or by using subscript syntax.
## String Indices
Each `String` value has an associated _index type_, `String.Index`, which corresponds to the position of each `Character` in the string.

As mentioned above, different characters can require different amounts of memory to store, so in order to determine which `Character` is at a particular position, you must iterate over each Unicode scalar from the start or end of that `String`. For this reason, Swift strings can’t be indexed by integer values.

Use the `startIndex` property to access the position of the first `Character` of a `String`. The `endIndex` property is the position after the last character in a `String`. As a result, the `endIndex`property isn’t a valid argument to a string’s subscript. If a `String` is empty, `startIndex` and `endIndex` are equal.

You access the indices before and after a given index using the `index(before:)` and `index(after:)` methods of `String`. To access an index farther away from the given index, you can use the `index(_:offsetBy:)` method instead of calling one of these methods multiple times.

Attempting to access an index outside of a string’s range or a `Character` at an index outside of a string’s range will trigger a runtime error.

Use the `indices` property to access all of the indices of individual characters in a string.
```swift
for index in greeting.indices {
	print("\(greeting[index]) ", terminator: "")
}
4.  // Prints "G u t e n T a g ! "
```
# Substrings
When you get a substring from a string—for example, using a subscript or a method like `prefix(_:)`—the result is an instance of [`Substring`](https://developer.apple.com/documentation/swift/substring), not another string. Substrings in Swift have most of the same methods as strings, which means you can work with substrings the same way you work with strings. However, unlike strings, you use substrings for only a short amount of time while performing actions on a string. When you’re ready to store the result for a longer time, you convert the substring to an instance of `String`. For example:
```swift
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"

// Convert the result to a String for long-term storage.
let newString = String(beginning)
```
# Comparing Strings
You can use different methods like:
- `hasSuffix(_:)`
-  `hasPrefix(_:)`

