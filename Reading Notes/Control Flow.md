Much of this should really just be review from OOP..

# Early Exit
A `guard` statement, like an `if` statement, executes statements depending on the Boolean value of an expression. You use a `guard` statement to require that a condition must be true in order for the code after the `guard` statement to be executed. Unlike an `if` statement, a `guard` statement always has an `else` clause—the code inside the `else` clause is executed if the condition isn’t true.
```swift
func greet(person: [String: String]) {
	guard let name = person["name"] else {
		return
	}

	print("Hello \(name)!")

	guard let location = person["location"] else {
		print("I hope the weather is nice near you.")
			return
	}

	print("I hope the weather is nice in \
	(location).")
}

	greet(person: ["name": "John"])
	// Prints "Hello John!"
	// Prints "I hope the weather is nice near you."
	greet(person: ["name": "Jane", "location": "Cupertino"])
	// Prints "Hello Jane!"
	// Prints "I hope the weather is nice in Cupertino."
```
If the `guard` statement’s condition is met, code execution continues after the `guard` statement’s closing brace. Any variables or constants that were assigned values using an optional binding as part of the condition are available for the rest of the code block that the `guard` statement appears in.

If that condition isn’t met, the code inside the `else` branch is executed. That branch must transfer control to exit the code block in which the `guard` statement appears. It can do this with a control transfer statement such as `return`, `break`, `continue`, or `throw`, or it can call a function or method that doesn’t return, such as `fatalError(_:file:line:)`.

Using a `guard` statement for requirements improves the readability of your code, compared to doing the same check with an `if` statement. It lets you write the code that’s typically executed without wrapping it in an `else` block, and it lets you keep the code that handles a violated requirement next to the requirement.
# Conditional Statements
Swift provides two ways to add conditional branches to your code: the `if` statement and the `switch` statement. Typically, you use the `if` statement to evaluate simple conditions with only a few possible outcomes. The `switch` statement is better suited to more complex conditions with multiple possible permutations and is useful in situations where pattern matching can help select an appropriate code branch to execute.
## Value Bindings
A `switch` case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is known as _value binding_, because the values are bound to temporary constants or variables within the case’s body.

The example below takes an (x, y) point, expressed as a tuple of type `(Int, Int)`, and categorizes it on the graph that follows:
```swift
let anotherPoint = (2,0)
switch anotherPoint {
case (let x, 0):
	print("on the x-axis with an x value of \(x)")
case (0, let y):
	print("on the y-axis with a y value of \(y)")
case let (x,y):
	print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with x value of 2"
```
The three `switch` cases declare placeholder constants `x` and `y`, which temporarily take on one or both tuple values from `anotherPoint`. The first case, `case (let x, 0)`, matches any point with a `y` value of `0` and assigns the point’s `x` value to the temporary constant `x`. Similarly, the second case, `case (0, let y)`, matches any point with an `x` value of `0` and assigns the point’s `y` value to the temporary constant `y`.

After the temporary constants are declared, they can be used within the case’s code block. Here, they’re used to print the categorization of the point.

This `switch` statement doesn’t have a `default` case. The final case, `case let (x, y)`, declares a tuple of two placeholder constants that can match any value. Because `anotherPoint` is always a tuple of two values, this case matches all possible remaining values, and a `default` case isn’t needed to make the `switch` statement exhaustive.
## Where
A `switch` case can use a `where` clause to check for additional conditions.
```swift
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x,y) where x == y:
	print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
	 print("(\(x), \(y)) is on the line x == -y")
case let (x,y):
	print("(\(x), \(y)) is just some arbitrary point")
}
// Prints "(1, -1) is on the line x == -y"
```
The three `switch` cases declare placeholder constants `x` and `y`, which temporarily take on the two tuple values from `yetAnotherPoint`. These constants are used as part of a `where` clause, to create a dynamic filter. The `switch` case matches the current value of `point` only if the `where` clause’s condition evaluates to `true` for that value.

As in the previous example, the final case matches all possible remaining values, and so a `default` case isn’t needed to make the `switch` statement exhaustive.