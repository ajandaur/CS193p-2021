![[Screen Shot 2021-08-06 at 9.48.58 AM.png]]
## The Model
- Completely UI independent 
- captures all the **data + logic **
- ** What your application IS and what it DOES**
- **The Model is the single source of Truth! **

## The View
- The View is the reflection of the current state of the model, AT ALL TIMES! 
- The View is considered Stateless since all the truth about the state of things is in the Model
- the @State in our Views, only have to do with how the view is **managing itself**
- The View is declared and 100% of what a View looks like is dependant on the body var --> this is considered declarative! 
- The View is also considered reactive!

## ViewModel
- Binds the view to the model and acts as an interpreter by being "exactly what the view needs"
- Serves as a gatekeeper for the model in terms of changing the model
- Important rule in MVVM --> **The View must always gets data from the Model by asking for it via the ViewModel**
- The ViewModel PASSES the data along and notices changes
- Once it notices a change --> the ViewModel publishes that "something changed" to the entire world
- ** We NEVER have a pointer or data structure in a ViewModel that knows anything about a View struct**
- It is up to the view to observe publications, pulls data, and rebuilds the view (The View SUBSCRIBES to the ViewModel)

## But how does the Model change via touch events happening in the View?? 
- Some of this must change the model.. right?
- This is known as **processing user intent** through these touch events
- This is accomplished via intent functions that go back to the ViewModel --> The ViewModel translates those intentions and modifies the Model appropriately

# Swift Type System
## Struct and Class
### Both:
- Can have stored variables
- Can have computed variables
- Both can have lets and vars
- Both can have functions as well
```swift
func multiply(operand: Int, by: Int) -> Int {
	return operand * by
}
multiply(operand: 5, by: 6)

// we can use an external and internal label though! 
func multiply(_ operand: Int, by otherOperand: Int) -> Int {
	return operand * by
}
multiply(5, by: 6)
```
- Both use initializers (special functions that are called when creating a struct or class)
### Differences:
#### Structs 
- Value types, COPIED when passed or assigned
- Copy on write = you don't actually get a copy of a data structure until you modify it
- Functional programming
- No inheritiance
- "Free" init initializes ALL vars
- Mutability must be EXPLICITLY STATED
- **This is the go-to data structure in SwiftUI**

#### Class
- Reference type, passed around via POINTERS
- Automitically reference counted = better than garbage collection, Swift keeps track of the # of pointers and removes the memory from the heap once the pointer count is 0
- OOP programming
- Inheritance (single)
- "Free" init initializes NO vars
- ALWAYS MUTABLE
- Used in specific circumstances when we need to share things
## "Don't Care" type (aka generics)
- Sometimes we want to manipulate data structures that we are "type agnostic" about.
- Swift is strongly-typed langauge, so we don't use variables that are "untyped"

Here is an example of a generic:
- An Array contains a bunch of things it doesn't care at all what the type is.
- But inside the Array's code, it has to have variables for the things it contains. They NEED types.

```swift 
struct Array<Element> {
	...
	func append(_ element: Element) { ... }
}

// using the Array
var a = Array<Int>()
a.append(5)
a.append(22)
```
- It's when you USE an array, that's when Element gets determined by Array(Int)

## Functions as Types 
- You can declare a variable (or parameter to a func or whatever) to be of type "function"
```swift
(Int, Int) -> Bool
(Double) -> Void
() -> Array<String>
() -> Void
```

### Closures 
- It's very common to pass functions around that we are often "inlining" them.

# Demo..

