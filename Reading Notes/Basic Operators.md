# Terminology
- You can have a Unary operator: operates on a single target (i.e. -a)
- Binary operator: operates on two targets (such as 2 + 3)
- Ternary operators: operate on three targets (a ? b : c).
# Assignment Operator
- Use it to initialize and update the value of a variable with the value of another variable
- Note that the assignment operator does not itself return a value. The following is invalid:
```swift
if x = y {
	// This isn't valid
}
```
# Arthimetic Operators
## Unary Minus Operator
- The sign of a numeric value can be toggled using a prefixed -, known as a **unary minus operator**:
```swift
let three = 3 
let minusThree = -three
let plusThree = -minusThree
```
Note: same concept applies to Unary Plus Operator.
# Compound Assignment Operators
  - You can use += and -= just like in C
# Comparison Operators
- Same comparison operators as you would see in C
- Each comparison operator returns a Bool value

You can compare two tuples if they have the same type and the same number of values. Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal. Those two values are compared, and the result of that comparison determines the overall result of the tuple comparison. If all the elements are equal, then the tuples themselves are equal. For example:
```swift
(1, "zebra") < (2, "apple") // true because 1 is less than 2; "zebra" and "apple" aren't compared
(3, "apple") < (3, "bird") // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog") // true because 4 is equal to 4, and "dog" is equal to "dog"
```
In the example above, you can see the left-to-right comparison behavior on the first line. Because `1` is less than `2`, `(1, "zebra")` is considered less than `(2, "apple")`, regardless of any other values in the tuples. It doesn’t matter that `"zebra"` isn’t less than `"apple"`, because the comparison is already determined by the tuples’ first elements. However, when the tuples’ first elements are the same, their second elements _are_ compared—this is what happens on the second and third line.
# Ternary Conditional Operator
The _ternary conditional operator_ is a special operator with three parts, which takes the form `question ? answer1 : answer2`. It’s a shortcut for evaluating one of two expressions based on whether `question` is true or false. If `question` is true, it evaluates `answer1` and returns its value; otherwise, it evaluates `answer2` and returns its value.
Example:
```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90
```
This example is shorthand for:
```swift
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
	rowHeight = contentHeight + 50
} else {
	rowHeight = contentHeight + 20
}
// rowHeight is equal to 90
```
Avoid combining multiple instances of the ternary conditional operator into one compound statement.
# Nil-Coalescing Operator
The _nil-coalescing operator_ (`a ?? b`) unwraps an optional `a` if it contains a value, or returns a default value `b` if `a` is `nil`. The expression `a` is always of an optional type. The expression `b` must match the type that’s stored inside `a`.
- This is shorthand for:
```swift
a != nil ? a! : b
```
The code above uses the ternary conditional operator and forced unwrapping (`a!`) to access the value wrapped inside `a` when `a` isn’t `nil`, and to return `b` otherwise. The nil-coalescing operator provides a more elegant way to encapsulate this conditional checking and unwrapping in a concise and readable form.
# Range Operators
- used to expressed range of values
## Closed Range Operator
- (a...b) defines a range that runs from a to b, and includes the values of a and b. **The value of a must NOT be greater than b**
## Half-Open Range Operator
The _half-open range operator_ (`a..<b`) defines a range that runs from `a` to `b`, but doesn’t include `b`. It’s said to be _half-open_ because it contains its first value, but not its final value. As with the closed range operator, the value of `a` must not be greater than `b`. If the value of `a` is equal to `b`, then the resulting range will be empty.

Half-open ranges are particularly useful when you work with zero-based lists such as arrays, where it’s useful to count up to (but not including) the length of the list:
```Swift
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
	print("Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack
```
## One-Sided Ranges
- When you want to continue as far as possible in one direction, like in a range that includes all the elements of an array from index 2 to the end of the array.
- One-sided ranges can be used in other contexts, not just in subscripts. You can’t iterate over a one-sided range that omits a first value, because it isn’t clear where iteration should begin. You _can_ iterate over a one-sided range that omits its final value; however, because the range continues indefinitely, make sure you add an explicit end condition for the loop. You can also check whether a one-sided range contains a particular value, as shown in the code below.
```swift
let range = ...5
range.contains(7) // false
range.contains(4) // true
range.contains(-1) // true
```
# Logical Operators
Logical operators_ modify or combine the Boolean logic values `true` and `false`. Swift supports the three standard logical operators found in C-based languages:
- Logical NOT (!a)
- Logical AND (a && b)
- Logical OR (a || b)
## Combining Logical Operators
```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || 				  	knowsOverridePassword {
	print("Welcome!")
} else {
	print("ACCESS DENIED")
}
6.  // Prints "Welcome!"
```
This example uses multiple `&&` and `||` operators to create a longer compound expression. However, the `&&` and `||` operators still operate on only two values, so this is actually three smaller expressions chained together. The example can be read as:

If we’ve entered the correct door code and passed the retina scan, or if we have a valid door key, or if we know the emergency override password, then allow access.

Based on the values of `enteredDoorCode`, `passedRetinaScan`, and `hasDoorKey`, the first two subexpressions are `false`. However, the emergency override password is known, so the overall compound expression still evaluates to `true`.
