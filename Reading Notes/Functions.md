# Function Argument Labels and Parameter Names
Each function parameter has both an _argument label_ and a _parameter name_. The argument label is used when calling the function; each argument is written in the function call with its argument label before it. The parameter name is used in the implementation of the function. By default, parameters use their parameter name as their argument label.
```swift
func someFunction(firstParameterName: Int, secondParameterName: Int) {
	// In the function body, firstParameterName and secondParameterName
	// refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)
```
All parameters must have unique names. Although it’s possible for multiple parameters to have the same argument label, unique argument labels help make your code more readable.
## Default Parameter Values
You can define a _default value_ for any parameter in a function by assigning a value to the parameter after that parameter’s type. If a default value is defined, you can omit that parameter when calling the function.
```swift
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
	// If you omit the second argument when calling this function, then
	// the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
```
Place parameters that don’t have default values at the beginning of a function’s parameter list, before the parameters that have default values. Parameters that don’t have default values are usually more important to the function’s meaning—writing them first makes it easier to recognize that the same function is being called, regardless of whether any default parameters are omitted.
## Function Types as Parameter Types
You can use a function type such as `(Int, Int) -> Int` as a parameter type for another function. This enables you to leave some aspects of a function’s implementation for the function’s caller to provide when the function is called.

Here’s an example to print the results of the math functions from above:
```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
	print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
```
This example defines a function called `printMathResult(_:_:_:)`, which has three parameters. The first parameter is called `mathFunction`, and is of type `(Int, Int) -> Int`. You can pass any function of that type as the argument for this first parameter. The second and third parameters are called `a` and `b`, and are both of type `Int`. These are used as the two input values for the provided math function.

When `printMathResult(_:_:_:)` is called, it’s passed the `addTwoInts(_:_:)`function, and the integer values `3` and `5`. It calls the provided function with the values `3` and `5`, and prints the result of `8`.

The role of `printMathResult(_:_:_:)` is to print the result of a call to a math function of an appropriate type. It doesn’t matter what that function’s implementation actually does—it matters only that the function is of the correct type. This enables `printMathResult(_:_:_:)` to hand off some of its functionality to the caller of the function in a type-safe way.
# Nested Functions
All of the functions you have encountered so far in this chapter have been examples of _global functions_, which are defined at a global scope. You can also define functions inside the bodies of other functions, known as _nested functions_.

Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function. An enclosing function can also return one of its nested functions to allow the nested function to be used in another scope.

You can rewrite the `chooseStepFunction(backward:)` example above to use and return nested functions:
```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
	func stepForward(input: Int) -> Int { return input + 1 }
	func stepBackward(input: Int) -> Int { return input - 1 }
	return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
	print("\(currentValue)... ")
	currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
```
