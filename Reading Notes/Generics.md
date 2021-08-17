_Generic code_ enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code. In fact, you’ve been using generics throughout the _Language Guide_, even if you didn’t realize it. For example, Swift’s `Array` and `Dictionary` types are both generic collections. You can create an array that holds `Int` values, or an array that holds `String` values, or indeed an array for any other type that can be created in Swift. Similarly, you can create a dictionary to store values of any specified type, and there are no limitations on what that type can be.	
# The Problem that Generics Solve
It’s more useful, and considerably more flexible, to write a single function that swaps two values of _any_ type. Generic code enables you to write such a function. (A generic version of these functions is defined below.)
# Generic Functions
_Generic functions_ can work with any type. Here’s a generic version of the `swapTwoInts(_:_:)` function from above, called `swapTwoValues(_:_:)`:
```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
	let temporaryA = a
	a = b
	b = temporaryA
}
```
The body of the `swapTwoValues(_:_:)` function is identical to the body of the `swapTwoInts(_:_:)` function. However, the first line of `swapTwoValues(_:_:)` is slightly different from `swapTwoInts(_:_:)`.
```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int)
func swapTwoValues<T>(_ a: inout T, _ b: inout T)
```
The generic version of the function uses a _placeholder_ type name (called `T`, in this case) instead of an _actual_ type name (such as `Int`, `String`, or `Double`). The placeholder type name doesn’t say anything about what `T` must be, but it _does_ say that both `a` and `b` must be of the same type `T`, whatever `T` represents. The actual type to use in place of `T` is determined each time the `swapTwoValues(_:_:)` function is called.

The other difference between a generic function and a nongeneric function is that the generic function’s name (`swapTwoValues(_:_:)`) is followed by the placeholder type name (`T`) inside angle brackets (`<T>`). The brackets tell Swift that `T` is a placeholder type name within the `swapTwoValues(_:_:)` function definition. Because `T` is a placeholder, Swift doesn’t look for an actual type called `T`.

The `swapTwoValues(_:_:)` function can now be called in the same way as `swapTwoInts`, except that it can be passed two values of _any_ type, as long as both of those values are of the same type as each other. Each time `swapTwoValues(_:_:)` is called, the type to use for `T` is inferred from the types of values passed to the function.
# Type Parameters
In the `swapTwoValues(_:_:)` example above, the placeholder type `T` is an example of a _type parameter_. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as `<T>`).

Once you specify a type parameter, you can use it to define the type of a function’s parameters (such as the `a` and `b` parameters of the `swapTwoValues(_:_:)` function), or as the function’s return type, or as a type annotation within the body of the function. In each case, the type parameter is replaced with an _actual_ type whenever the function is called. (In the `swapTwoValues(_:_:)` example above, `T` was replaced with `Int` the first time the function was called, and was replaced with `String` the second time it was called.)

You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
# Naming Type Parameters
In most cases, type parameters have descriptive names, such as `Key` and `Value` in `Dictionary<Key, Value>` and `Element` in `Array<Element>`, which tells the reader about the relationship between the type parameter and the generic type or function it’s used in. However, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as `T`, `U`, and `V`, such as `T` in the `swapTwoValues(_:_:)` function above.
# Generic Types
In addition to generic functions, Swift enables you to define your own _generic types_. These are custom classes, structures, and enumerations that can work with _any_ type, in a similar way to `Array` and `Dictionary`.

This section shows you how to write a generic collection type called `Stack`. A stack is an ordered set of values, similar to an array, but with a more restricted set of operations than Swift’s `Array` type. An array allows new items to be inserted and removed at any location in the array. A stack, however, allows new items to be appended only to the end of the collection (known as _pushing_ a new value on to the stack). Similarly, a stack allows items to be removed only from the end of the collection (known as _popping_ a value off the stack).![[Screen Shot 2021-08-16 at 10.37.32 AM.png]]
```swift
struct IntStack {
	var items: [Int] = []
	mutating func push(_ item: Int) {
		items.append(item)
		}
		mutating func pop() -> Int {
			return items.removeLast()
		}
	}
```
This structure uses an `Array` property called `items` to store the values in the stack. `Stack` provides two methods, `push` and `pop`, to push and pop values on and off the stack. These methods are marked as `mutating`, because they need to modify (or _mutate_) the structure’s `items` array.

The `IntStack` type shown above can only be used with `Int` values, however. It would be much more useful to define a _generic_ `Stack` class, that can manage a stack of _any_ type of value.
```swift
struct Stack<Element> {
	var items: [Element] = []
	mutating func push(_ item: Element) {
		items.append(item)
		}
		mutating func pop() -> Element {
			return items.removeLast()
		}
	}
```
Note how the generic version of `Stack` is essentially the same as the nongeneric version, but with a type parameter called `Element` instead of an actual type of `Int`. This type parameter is written within a pair of angle brackets (`<Element>`) immediately after the structure’s name.

`Element` defines a placeholder name for a type to be provided later. This future type can be referred to as `Element` anywhere within the structure’s definition. In this case, `Element` is used as a placeholder in three places:

-   To create a property called `items`, which is initialized with an empty array of values of type `Element`
-   To specify that the `push(_:)` method has a single parameter called `item`, which must be of type `Element`
-   To specify that the value returned by the `pop()` method will be a value of type `Element`

Because it’s a generic type, `Stack` can be used to create a stack of _any_ valid type in Swift, in a similar manner to `Array` and `Dictionary`.

You create a new `Stack` instance by writing the type to be stored in the stack within angle brackets. For example, to create a new stack of strings, you write `Stack<String>()`:
```swift
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings
```
# Extending a Generic Type
When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the _original_ type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.
# Type Constraints
The `swapTwoValues(_:_:)` function and the `Stack` type can work with any type. However, it’s sometimes useful to enforce certain _type constraints_ on the types that can be used with generic functions and generic types. Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.

For example, Swift’s `Dictionary` type places a limitation on the types that can be used as keys for a dictionary. As described in [Dictionaries](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html#ID113), the type of a dictionary’s keys must be _hashable_. That is, it must provide a way to make itself uniquely representable. `Dictionary` needs its keys to be hashable so that it can check whether it already contains a value for a particular key. Without this requirement, `Dictionary` couldn’t tell whether it should insert or replace a value for a particular key, nor would it be able to find a value for a given key that’s already in the dictionary.

This requirement is enforced by a type constraint on the key type for `Dictionary`, which specifies that the key type must conform to the `Hashable` protocol, a special protocol defined in the Swift standard library. All of Swift’s basic types (such as `String`, `Int`, `Double`, and `Bool`) are hashable by default. For information about making your own custom types conform to the `Hashable` protocol, see [Conforming to the Hashable Protocol](https://developer.apple.com/documentation/swift/hashable#2849490).

You can define your own type constraints when creating custom generic types, and these constraints provide much of the power of generic programming. Abstract concepts like `Hashable` characterize types in terms of their conceptual characteristics, rather than their concrete type.
## Type Constraint Syntax
You write type constraints by placing a single class or protocol constraint after a type parameter’s name, separated by a colon, as part of the type parameter list. The basic syntax for type constraints on a generic function is shown below (although the syntax is the same for generic types):
```swift
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
	// function body goes here
}
```
The hypothetical function above has two type parameters. The first type parameter, `T`, has a type constraint that requires `T` to be a subclass of `SomeClass`. The second type parameter, `U`, has a type constraint that requires `U` to conform to the protocol `SomeProtocol`.
## Type Constaints in Action
Here’s a nongeneric function called `findIndex(ofString:in:)`, which is given a `String` value to find and an array of `String` values within which to find it. The `findIndex(ofString:in:)` function returns an optional `Int` value, which will be the index of the first matching string in the array if it’s found, or `nil` if the string can’t be found:
```swift
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
	for (index, value) in array.enumerated() {
		if value == valueToFind {
			return index
		}
	}
	return nil
}
```
The `findIndex(ofString:in:)` function can be used to find a string value in an array of strings:
```swift
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
	print("The index of llama is \(foundIndex)")
}
// Prints "The index of llama is 2"
```
The principle of finding the index of a value in an array isn’t useful only for strings, however. You can write the same functionality as a generic function by replacing any mention of strings with values of some type `T` instead.

Here’s how you might expect a generic version of `findIndex(ofString:in:)`, called `findIndex(of:in:)`, to be written. Note that the return type of this function is still `Int?`, because the function returns an optional index number, not an optional value from the array. Be warned, though—this function doesn’t compile, for reasons explained after the example:
```swift
func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
	for (index,value) in array.enumerated() {
		if value == valueToFind {
			return index
		}
	}
	return nil
}
```
This function doesn’t compile as written above. The problem lies with the equality check, “`if value == valueToFind`”. Not every type in Swift can be compared with the equal to operator (`==`). If you create your own class or structure to represent a complex data model, for example, then the meaning of “equal to” for that class or structure isn’t something that Swift can guess for you. Because of this, it isn’t possible to guarantee that this code will work for _every_ possible type `T`, and an appropriate error is reported when you try to compile the code.

All is not lost, however. The Swift standard library defines a protocol called `Equatable`, which requires any conforming type to implement the equal to operator (`==`) and the not equal to operator (`!=`) to compare any two values of that type. All of Swift’s standard types automatically support the `Equatable` protocol.

Any type that’s `Equatable` can be used safely with the `findIndex(of:in:)` function, because it’s guaranteed to support the equal to operator. To express this fact, you write a type constraint of `Equatable` as part of the type parameter’s definition when you define the function:
```swift
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
	for (index, value) in array.enumerated() {
		if value == valueToFind {
		return index
		}
	}
	return nil
}
```
# Generic Where Clauses
Type constraints, as described in [Type Constraints](https://docs.swift.org/swift-book/LanguageGuide/Generics.html#ID186), enable you to define requirements on the type parameters associated with a generic function, subscript, or type.

It can also be useful to define requirements for associated types. You do this by defining a _generic where clause_. A generic `where` clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same. A generic `where` clause starts with the `where` keyword, followed by constraints for associated types or equality relationships between types and associated types. You write a generic `where` clause right before the opening curly brace of a type or function’s body.
# Extension with a Generic Where Clause 
You can also use a generic `where` clause as part of an extension. The example below extends the generic `Stack` structure from the previous examples to add an `isTop(_:)` method.
```swift
extension Stack where Element: Equatable { 
	func isTop(_ item: Element) -> Bool { 
		guard let topItem = items.last else {
			return false 
		}
		return topItem == item
	}
}
```
This new `isTop(_:)` method first checks that the stack isn’t empty, and then compares the given item against the stack’s topmost item. If you tried to do this without a generic `where` clause, you would have a problem: The implementation of `isTop(_:)` uses the `==` operator, but the definition of `Stack` doesn’t require its items to be equatable, so using the `==` operator results in a compile-time error. Using a generic `where` clause lets you add a new requirement to the extension, so that the extension adds the `isTop(_:)` method only when the items in the stack are equatable.