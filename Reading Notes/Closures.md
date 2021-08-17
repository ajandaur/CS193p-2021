_Closures_ are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as _closing over_ those constants and variables. Swift handles all of the memory management of capturing for you.

Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:

-   Inferring parameter and return value types from context
-   Implicit returns from single-expression closures
-   Shorthand argument names
-   Trailing closure syntax
 # Closure Expressions
 It is useful to write shorter versions of function-like constructs as compared to Nestign Functions. This is particularly true when you work with functions or methods that take functions as one or more of their arguments.
## Syntax
Closure expression syntax has the following general form:
```swift
{ (parameters) -> return type in
 statements
}
```
The _parameters_ in closure expression syntax can be in-out parameters, but they can’t have a default value. Variadic parameters can be used if you name the variadic parameter. Tuples can also be used as parameter types and return types.
# Trailing Closures
If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a _trailing closure_ instead. You write a trailing closure after the function call’s parentheses, even though the trailing closure is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the first closure as part of the function call. A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.
```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
	// function body goes here
}

// Here's how you call this function without using a trailing closure:

	someFunctionThatTakesAClosure(closure: {
	// closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
	// trailing closure's body goes here
}
```
# Capturing Values 
A closure can _capture_ constants and variables from the surrounding context in which it’s defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.

In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.
# Closures Are REFERENCE TYPES
- Functions and closures are REFERENCE types 
- Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a _reference_ to the function or closure.
# Escaping Closures
A closure is said to _escape_ a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write `@escaping` before the parameter’s type to indicate that the closure is allowed to escape.

One way that a closure can escape is by being stored in a variable that’s defined outside the function. As an example, many functions that start an asynchronous operation take a closure argument as a completion handler. The function returns after it starts the operation, but the closure isn’t called until the operation is completed—the closure needs to escape, to be called later. For example:
```swift
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
	completionHandlers.append(completionHandler)
}
```
The `someFunctionWithEscapingClosure(_:)` function takes a closure as its argument and adds it to an array that’s declared outside the function. If you didn’t mark the parameter of this function with `@escaping`, you would get a compile-time error.

An escaping closure that refers to `self` needs special consideration if `self` refers to an instance of a class. Capturing `self` in an escaping closure makes it easy to accidentally create a strong reference cycle. For information about reference cycles, see [Automatic Reference Counting](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html).
Normally, a closure captures variables implicitly by using them in the body of the closure, but in this case you need to be explicit. If you want to capture `self`, write `self` explicitly when you use it, or include `self` in the closure’s capture list. Writing `self` explicitly lets you express your intent, and reminds you to confirm that there isn’t a reference cycle. For example, in the code below, the closure passed to `someFunctionWithEscapingClosure(_:)` refers to `self` explicitly. In contrast, the closure passed to `someFunctionWithNonescapingClosure(_:)` is a nonescaping closure, which means it can refer to `self` implicitly.
```swift
func someFunctionWithNonescapingClosure(closure: () -> Void) {
	closure()
}

class SomeClass {
	var x = 10
	func doSomething() {
	someFunctionWithEscapingClosure { self.x = 100 }
	someFunctionWithNonescapingClosure { x = 200 }
	}
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"
```
- Escaping closures CAN'T CAPTURE a mutable reference to self for structures