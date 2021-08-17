A _protocol_ defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be _adopted_ by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to _conform_ to that protocol.

In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.
# Protocol Syntax
```swift
protocol SomeProtocol {
	// protocol definition goes here
}
```
- IF a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma.
# Property Requirements
A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. **The protocol also specifies whether each property must be gettable or gettable _and_ settable.**

If a protocol requires a property to be gettable and settable, that property requirement can’t be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it’s valid for the property to be also settable if this is useful for your own code.

Property requirements are always declared as variable properties, prefixed with the `var` keyword. Gettable and settable properties are indicated by writing `{ get set }` after their type declaration, and gettable properties are indicated by writing `{ get }`.
```swift
protocol SomeProtocol {
	var mustBeSettable: Int { get set }
	var doesNotNeedToBeSettable: Int { get }
}
```
Always prefix type property requirements with the `static` keyword when you define them in a protocol. This rule pertains even though type property requirements can be prefixed with the `class` or `static` keyword when implemented by a class:
```swift
protocol AnotherProtocol { 
	static var someTypeProperty: Int { get set }
}
```
Here's an example of a protocl with a single instance property requirement:
```swift
protocol FullyNamed { 
	var fullName: String { get }
}
```
The `FullyNamed` protocol requires a conforming type to provide a fully qualified name. The protocol doesn’t specify anything else about the nature of the conforming type—it only specifies that the type must be able to provide a full name for itself. The protocol states that any `FullyNamed` type must have a gettable instance property called `fullName`, which is of type `String`.
# Method Requirements 
Protocols can require specific instance methods and type methods to be implemented by conforming types. These methods are written as part of the protocol’s definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body. Variadic parameters are allowed, subject to the same rules as for normal methods. Default values, however, can’t be specified for method parameters within a protocol’s definition.

As with type property requirements, you always prefix type method requirements with the `static` keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the `class` or `static` keyword when implemented by a class:
```swift
protocol SomeProtocol {
	static func someTypeMethod()
}
```
The following example defines a protocol with a single instance method requirement:
```swift
protocol RandomNumberGenerator {
	func random() -> Double 
}
```
This protocol, `RandomNumberGenerator`, requires any conforming type to have an instance method called `random`, which returns a `Double` value whenever it’s called. Although it’s not specified as part of the protocol, it’s assumed that this value will be a number from `0.0` up to (but not including) `1.0`.

**The `RandomNumberGenerator` protocol doesn’t make any assumptions about how each random number will be generated—it simply requires the generator to provide a standard way to generate a new random number.**

Here’s an implementation of a class that adopts and conforms to the `RandomNumberGenerator` protocol. This class implements a pseudorandom number generator algorithm known as a _linear congruential generator_:
```swift
class LinearCongruentialGenerator: RandomNumberGenerator {
	var lastRandom = 42.0
	let m = 139968.0
	let a = 3877.0
	let c = 29573.0
	func random() -> Double {
		lastRandom = ((lastRandom * a + c)
	
	.truncatingRemainder(dividingBy:m))
		return lastRandom / m
	}
}
	let generator = LinearCongruentialGenerator()
	print("Here's a random number: \(generator.random())")
	// Prints "Here's a random number: 0.3746499199817101"
	print("And another one: \(generator.random())")
	// Prints "And another one: 0.729023776863283"
```
# Mutating Method Requirements
It’s sometimes necessary for a method to modify (or _mutate_) the instance it belongs to. For instance methods on value types (that is, structures and enumerations) you place the `mutating` keyword before a method’s `func` keyword to indicate that the method is allowed to modify the instance it belongs to and any properties of that instance. This process is described in [Modifying Value Types from Within Instance Methods](https://docs.swift.org/swift-book/LanguageGuide/Methods.html#ID239).

If you define a protocol instance method requirement that’s intended to mutate instances of any type that adopts the protocol, mark the method with the `mutating` keyword as part of the protocol’s definition. This enables structures and enumerations to adopt the protocol and satisfy that method requirement.
# Initializer Requirements
Protocols can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:
```swift
protocol SomeProtocol {
	init(someParameter: Int)
}
```
# Class Implementations of Protocol Initializer Requirements
You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the `required` modifier:
```swift
class SomeClass: SomeProtocol {
	required init(someParameter: Int) {
		// initializer implementation goes here 
	}
}			
```
The use of the `required` modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.
# Protocols as Types
Protocols don’t actually implement any functionality themselves. Nonetheless, you can use protocols as a fully fledged types in your code. Using a protocol as a type is sometimes called an _existential type_, which comes from the phrase “there exists a type _T_ such that _T_ conforms to the protocol”.

You can use a protocol in many places where other types are allowed, including:

-   As a parameter type or return type in a function, method, or initializer
-   As the type of a constant, variable, or property
-   As the type of items in an array, dictionary, or other container

**Because protocols are types, begin their names with a capital letter (such as `FullyNamed` and `RandomNumberGenerator`) to match the names of other types in Swift (such as `Int`, `String`, and `Double`).**

Example:
```swift
class Dice {
	let sides: Int 
	let generator: RandomNumberGenerator
	init(sides: Int, generator: RandomNumberGenerator()) {
		self.sides = sides
		self.generator = generator
		}
		func roll() -> Int { 
			return Int(generator.random() * Double(sides)) + 1 
	}
}
```
This example defines a new class called `Dice`, which represents an _n_-sided dice for use in a board game. `Dice` instances have an integer property called `sides`, which represents how many sides they have, and a property called `generator`, which provides a random number generator from which to create dice roll values.

The `generator` property is of type `RandomNumberGenerator`. Therefore, you can set it to an instance of _any_ type that adopts the `RandomNumberGenerator` protocol. Nothing else is required of the instance you assign to this property, except that the instance must adopt the `RandomNumberGenerator` protocol. Because its type is `RandomNumberGenerator`, code inside the `Dice` class can only interact with `generator` in ways that apply to all generators that conform to this protocol. That means it can’t use any methods or properties that are defined by the underlying type of the generator. However, you can downcast from a protocol type to an underlying type in the same way you can downcast from a superclass to a subclass, as discussed in [Downcasting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html#ID341).

`Dice` also has an initializer, to set up its initial state. This initializer has a parameter called `generator`, which is also of type `RandomNumberGenerator`. You can pass a value of any conforming type in to this parameter when initializing a new `Dice` instance.

`Dice` provides one instance method, `roll`, which returns an integer value between 1 and the number of sides on the dice. This method calls the generator’s `random()` method to create a new random number between `0.0` and `1.0`, and uses this random number to create a dice roll value within the correct range. Because `generator` is known to adopt `RandomNumberGenerator`, it’s guaranteed to have a `random()` method to call.

Here’s how the `Dice` class can be used to create a six-sided dice with a `LinearCongruentialGenerator` instance as its random number generator:
```swift
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
	print("Random dice roll is \(d6.roll())")
}
```
# Delegation
_Delegation_ is a design pattern that enables a class or structure to hand off (or _delegate_) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.

The example below defines two protocols for use with dice-based board games:
```swift
protocol DiceGame {
	var dice: Dice { get }
	func play()
}
protocol DiceGameDelegate: AnyObject {
	func gameDidStart(_ game: DiceGame)
	func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRool: Int)
		func gameDidEnd(_ game: DiceGame)
}
```
The `DiceGame` protocol is a protocol that can be adopted by any game that involves dice.

The `DiceGameDelegate` protocol can be adopted to track the progress of a `DiceGame`. To prevent strong reference cycles, delegates are declared as weak references. For information about weak references, see [Strong Reference Cycles Between Class Instances](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html#ID51). Marking the protocol as class-only lets the `SnakesAndLadders` class later in this chapter declare that its delegate must use a weak reference. A class-only protocol is marked by its inheritance from `AnyObject`, as discussed in [Class-Only Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID281).
# Adding Protocol Conformance with an Extension
You can extend an existing type to adopt and conform to a new protocol, even if you don’t have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand. For more about extensions, see [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html).

For example, this protocol, called `TextRepresentable`, can be implemented by any type that has a way to be represented as text. This might be a description of itself, or a text version of its current state:
```swift
protocol TextRepresentable {
	var textualDescription: String { get }
}
```
Similarly, the `SnakesAndLadders` game class can be extended to adopt and conform to the `TextRepresentable` protocol:
```swift
extension SnakesAndLadders: TextRepresentable {
	var textualDescription: String {
		return "A game of Snakes nad Ladders with \(finalSquare) squares"
	}
}
print(game.textualDescription)
// Prints "A game of Snakes and Ladders with 25 squares"
```
## Conditionally Conforming to a Protocol
A generic type may be able to satisfy the requirements of a protocol only under certain conditions, such as when the type’s generic parameter conforms to the protocol. You can make a generic type conditionally conform to a protocol by listing constraints when extending the type. Write these constraints after the name of the protocol you’re adopting by writing a generic `where` clause. For more about generic `where` clauses, see [Generic Where Clauses](https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID192).
## Adopting a Protocol Using a Synthesized Implementation
Swift can automatically provide the protocol conformance for `Equatable`, `Hashable`, and `Comparable` in many simple cases. Using this synthesized implementation means you don’t have to write repetitive boilerplate code to implement the protocol requirements yourself.

Swift provides a synthesized implementation of `Equatable` for the following kinds of custom types:

-   Structures that have only stored properties that conform to the `Equatable` protocol
-   Enumerations that have only associated types that conform to the `Equatable` protocol
-   Enumerations that have no associated types

To receive a synthesized implementation of `==`, declare conformance to `Equatable` in the file that contains the original declaration, without implementing an `==` operator yourself. The `Equatable` protocol provides a default implementation of `!=`.

Swift provides a synthesized implementation of `Hashable` for the following kinds of custom types:

-   Structures that have only stored properties that conform to the `Hashable` protocol
-   Enumerations that have only associated types that conform to the `Hashable` protocol
-   Enumerations that have no associated types

To receive a synthesized implementation of `hash(into:)`, declare conformance to `Hashable` in the file that contains the original declaration, without implementing a `hash(into:)` method yourself.

Swift provides a synthesized implementation of `Comparable` for enumerations that don’t have a raw value. If the enumeration has associated types, they must all conform to the `Comparable` protocol. To receive a synthesized implementation of `<`, declare conformance to `Comparable` in the file that contains the original enumeration declaration, without implementing a `<` operator yourself. The `Comparable` protocol’s default implementation of `<=`, `>`, and `>=` provides the remaining comparison operators.
# Collections of Protocol Types
A protocol can be used as the type to be stored in a collection such as an array or a dictionary, as mentioned in [Protocols as Types](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID275). This example creates an array of `TextRepresentable` things:
```swift
let things: [TextRepresentable] = [game, d12, simonTheHamster]
```
t’s now possible to iterate over the items in the array, and print each item’s textual description:
```swift
for thing in things {
	print(thing.textualDescription)
}
```
Note that the `thing` constant is of type `TextRepresentable`. It’s not of type `Dice`, or `DiceGame`, or `Hamster`, even if the actual instance behind the scenes is of one of those types. Nonetheless, because it’s of type `TextRepresentable`, and anything that’s `TextRepresentable` is known to have a `textualDescription` property, it’s safe to access `thing.textualDescription` each time through the loop
# Protocol Inheritance
You can use the `is` and `as` operators described in [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) to check for protocol conformance, and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:

-   The `is` operator returns `true` if an instance conforms to a protocol and returns `false` if it doesn’t.
-   The `as?` version of the downcast operator returns an optional value of the protocol’s type, and this value is `nil` if the instance doesn’t conform to that protocol.
-   The `as!` version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast doesn’t succeed.

# Class-Only Protocols
You can limit protocol adoption to class types (and not structures or enumerations) by adding the `AnyObject` protocol to a protocol’s inheritance list.
```swift
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
	// class-only protocol definition goes here
}
```
In the example above, `SomeClassOnlyProtocol` can only be adopted by class types. It’s a compile-time error to write a structure or enumeration definition that tries to adopt `SomeClassOnlyProtocol`.
# Protocol Composition
t can be useful to require a type to conform to multiple protocols at the same time. You can combine multiple protocols into a single requirement with a _protocol composition_. Protocol compositions behave as if you defined a temporary local protocol that has the combined requirements of all protocols in the composition. Protocol compositions don’t define any new protocol types.

Protocol compositions have the form `SomeProtocol & AnotherProtocol`. You can list as many protocols as you need, separating them with ampersands (`&`). In addition to its list of protocols, a protocol composition can also contain one class type, which you can use to specify a required superclass.
# Protocol Extensions
Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.

For example, the `RandomNumberGenerator` protocol can be extended to provide a `randomBool()` method, which uses the result of the required `random()` method to return a random `Bool` value:
```swift
extension RandomNumberGenerator {
	func randomBool() -> Bool {
		return random() > 0.5
	}
}
```
Protocol extensions can add implementations to conforming types but can’t make a protocol extend or inherit from another protocol. Protocol inheritance is always specified in the protocol declaration itself.
## Providing Default Implementations
You can use protocol extensions to provide a default implementation to any method or computed property requirement of that protocol. If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
## Adding Constraints to Protocol Extensions
When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending by writing a generic `where` clause. For more about generic `where` clauses, see [Generic Where Clauses](https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID192).
