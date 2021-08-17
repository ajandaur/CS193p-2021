**This is going to be an important sectioon, read this carefully. It is one of the building blocks of functional programming**

_Extensions_ add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don’t have access to the original source code (known as _retroactive modeling_). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions don’t have names.)

Extensions in Swift can:

-   Add computed instance properties and computed type properties
-   Define instance methods and type methods
-   Provide new initializers
-   Define subscripts
-   Define and use new nested types
-   Make an existing type conform to a protocol

In Swift, you can even extend a protocol to provide implementations of its requirements or add additional functionality that conforming types can take advantage of. For more details, see [Protocol Extensions](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521).
# Extension Syntax
```swift
extension SomeType {
	// new functionality to add to SomeType goes here
}
```
- An extension can extend an EXISTING type to make it adopt one or more protocls. To add protocol conformance, write the protocol names the say way as you write them for a class or structure:
```swift
extension SomeType: SomeProtocol, AnotherProtocol {
	// implementation of protocol requirements geos here
}
```
# Computed Properties
```swift
extension Double {
	var km: Double { return self * 1_000.0 }
	var m: Double { return self }
	var cm: Double { return self / 100.0 }
	var mm: Double { return self / 1_000.0 }
	var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"
```
These computed properties express that a `Double` value should be considered as a certain unit of length. Although they’re implemented as computed properties, the names of these properties can be appended to a floating-point literal value with dot syntax, as a way to use that literal value to perform distance conversions.

In this example, a `Double` value of `1.0` is considered to represent “one meter”. This is why the `m` computed property returns `self`—the expression `1.m` is considered to calculate a `Double` value of `1.0`.

Other units require some conversion to be expressed as a value measured in meters. One kilometer is the same as 1,000 meters, so the `km` computed property multiplies the value by `1_000.00` to convert into a number expressed in meters. Similarly, there are 3.28084 feet in a meter, and so the `ft` computed property divides the underlying `Double` value by `3.28084`, to convert it from feet to meters.

These properties are read-only computed properties, and so they’re expressed without the `get` keyword, for brevity. Their return value is of type `Double`, and can be used within mathematical calculations wherever a `Double` is accepted:
```swift
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"
```
# Initializers
Extensions can add new initializers to existing types. This enables you to extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation.

Extensions can add new convenience initializers to a class, but they can’t add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.

If you use an extension to add an initializer to a value type that provides default values for all of its stored properties and doesn’t define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension’s initializer. This wouldn’t be the case if you had written the initializer as part of the value type’s original implementation, as described in [Initializer Delegation for Value Types](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID215).

If you use an extension to add an initializer to a structure that was declared in another module, the new initializer can’t access `self` until it calls an initializer from the defining module.

The example below defines a custom `Rect` structure to represent a geometric rectangle. The example also defines two supporting structures called `Size` and `Point`, both of which provide default values of `0.0` for all of their properties:
```swift
struct Size {
	var width = 0.0, height = 0.0
}
struct Point {
	var x = 0.0, y = 0.0
}
struct Rect {
	var origin = Point()
	var size = Size()
}
```
Because the `Rect` structure provides default values for all of its properties, it receives a default initializer and a memberwise initializer automatically, as described in [Default Initializers](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID213).

You can extend the `Rect` structure to provide an additional initializer that takes a specific center point and size:
```swift
extension Rect {
init(center: Point, size: Size) {
	let originX = center.x - (size.width / 2)
	let originY = center.y - (size.height / 2)
	self.init(origin: Point(x: originX, y: originY), size: size)
	}
}
```
# Methods
Extensions can add new instance methods and type methods to existing types. The following example adds a new instance method called `repetitions` to the `Int` type:
```swift
extension Int { 
	func repetitions(task: () -> Void) {
		for _ in 0..<self {
		task()
		}
	}
}
```
The `repetitions(task:)` method takes a single argument of type `() -> Void`, which indicates a function that has no parameters and doesn’t return a value.

After defining this extension, you can call the `repetitions(task:)` method on any integer to perform a task that many number of times:
```swift
3.repetitions { 
	print("Hello")
}
// prints Hello 3x
```
- For mutating instance methods, you have to use the keyword "mutating" to modify self. **This includes structures and enumeration methods that modify self or its properties**
# Nested Types 
Extensions can add new nested types to existing classes, structures, and enumerations:
```swift
extension Int {
	enum Kind {
		case negative, zero, positive
	}
	var kind: Kind {
	switch self { 
	case 0: 
		return .zero
	case let x where x > 0:
		return .positive
	default: 
		return .negative
		}
	}
}
```
This example adds a new nested enumeration to `Int`. This enumeration, called `Kind`, expresses the kind of number that a particular integer represents. Specifically, it expresses whether the number is negative, zero, or positive.

This example also adds a new computed instance property to `Int`, called `kind`, which returns the appropriate `Kind` enumeration case for that integer.

The nested enumeration can now be used with any Int value: 
```swift
func printIntegerKind(_ numbers: [Int]) {
	for number in numbers {
		switch number.kind {
		case . negative: 
			print("- ", terminator: "")
		case .zero:
			print("0 ", terminator: "")
		case .positive:
			print("+", terminator: "")
			}
		}
		print("")
	}
	printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
	// Prints "+ + - 0 - 0 + "
```
This function, `printIntegerKinds(_:)`, takes an input array of `Int` values and iterates over those values in turn. For each integer in the array, the function considers the `kind` computed property for that integer, and prints an appropriate description.