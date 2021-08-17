 An _enumeration_ defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.

If you are familiar with C, you will know that C enumerations assign related names to a set of integer values. Enumerations in Swift are much more flexible, and don’t have to provide a value for each case of the enumeration. If a value (known as a _raw_ value) is provided for each enumeration case, the value can be a string, a character, or a value of any integer or floating-point type.

Alternatively, enumeration cases can specify associated values of _any_ type to be stored along with each different case value, much as unions or variants do in other languages. You can define a common set of related cases as part of one enumeration, each of which has a different set of values of appropriate types associated with it.

Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. Enumerations can also define initializers to provide an initial case value; can be extended to expand their functionality beyond their original implementation; and can conform to protocols to provide standard functionality.

For more about these capabilities, see [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html), [Methods](https://docs.swift.org/swift-book/LanguageGuide/Methods.html), [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html), [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html), and [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html).

## Enumeration Syntax 
You have to use the **enum** keyword and then put the definition within a pair of braces:
```swift
enum CompassPoint {
	case north
	case south
	case east
	case west 
}
```
- Note: You can put multiple cases on a single line but you need to separate them by commas!
# Matching Enumeration Values with a Switch Statement
You can match individual enumeration values with a `switch` statement:
```swift
	directionToHead = .south
	switch directionToHead {
	case .north:
		print("Lots of planets have a north")
	case .south:
		print("Watch out for penguins")
	case .east:
		print("Where the sun rises")
	case .west:
		print("Where the skies are blue")
}
	// Prints "Watch out for penguins"
```
As described in [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html), a `switch` statement must be exhaustive when considering an enumeration’s cases. If the `case` for `.west` is omitted, this code doesn’t compile, because it doesn’t consider the complete list of `CompassPoint` cases. Requiring exhaustiveness ensures that enumeration cases aren’t accidentally omitted.

You can also use a default case to cover any cases that aren't addressed explicitly:
```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth: 
	print("Mostly harmless")
default: 
	print("Not a safe place for humans")
}
// Prints "Mostly harmless"
```
# Iterating Over Enumeration Cases
For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing `: CaseIterable` after the enumeration’s name. Swift exposes a collection of all the cases as an `allCases` property of the enumeration type. Here’s an example:
```swift
enum Beverage: CaseIterable {
	case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"
```
In the example above, you write `Beverage.allCases` to access a collection that contains all of the cases of the `Beverage` enumeration. You can use `allCases` like any other collection—the collection’s elements are instances of the enumeration type, so in this case they’re `Beverage` values. 
# Associated Values
The examples in the previous section show how the cases of an enumeration are a defined (and typed) value in their own right. You can set a constant or variable to `Planet.earth`, and check for this value later. However, it’s sometimes useful to be able to store values of other types alongside these case values. This additional information is called an _associated value_, and it varies each time you use that case as a value in your code.

You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed. Enumerations similar to these are known as _discriminated unions_, _tagged unions_, or _variants_ in other programming languages.
# Raw Values
The barcode example in [Associated Values](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html#ID148) shows how cases of an enumeration can declare that they store associated values of different types. As an alternative to associated values, enumeration cases can come prepopulated with default values (called _raw values_), which are all of the same type.
# Recursive Enumerations
A _recursive enumeration_ is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing `indirect` before it, which tells the compiler to insert the necessary layer of indirection.