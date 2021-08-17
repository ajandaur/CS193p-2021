_Properties_ associate values with a particular class, structure, or enumeration. Stored properties store constant and variable values as part of an instance, whereas computed properties calculate (rather than store) a value. Computed properties are provided by classes, structures, and enumerations. **Stored properties are provided only by classes and structures.**

Stored and computed properties are usually associated with instances of a particular type. However, properties can also be associated with the type itself. Such properties are known as type properties.

In addition, you can define property observers to monitor changes in a property’s value, which you can respond to with custom actions. Property observers can be added to stored properties you define yourself, and also to properties that a subclass inherits from its superclass.

You can also use a property wrapper to reuse code in the getter and setter of multiple properties.
## Stored Properties
In its simplest form, a stored property is a constant or variable that’s stored as part of an instance of a particular class or structure. Stored properties can be either _variable stored properties_ (introduced by the `var` keyword) or _constant stored properties_ (introduced by the `let` keyword).

You can provide a default value for a stored property as part of its definition, as described in [Default Property Values](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID206). You can also set and modify the initial value for a stored property during initialization. This is true even for constant stored properties, as described in [Assigning Constant Properties During Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID212).
## Lazy Stored Properties
A _lazy stored property_ is a property whose initial value isn’t calculated until the first time it’s used. You indicate a lazy stored property by writing the `lazy` modifier before its declaration.

Lazy properties are useful when the initial value for a property is dependent on outside factors whose values aren’t known until after an instance’s initialization is complete. Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that shouldn’t be performed unless or until it’s needed.
# Computed Properties
In addition to stored properties, classes, structures, and enumerations can define _computed properties_, which don’t actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.
## Shorthand Setter Declaration
If a computed property’s setter doesn’t define a name for the new value to be set, a default name of `newValue` is used. Here’s an alternative version of the `Rect` structure that takes advantage of this shorthand notation:
```swift
struct AlternativeRect {
	var origin = Point()
	var size = Size()
	var center: Point {
		get {
			let centerX = origin.x + (size.width / 2)
			let centerY = origin.y + (size.height / 2)
			return Point(x: centerX, y: centerY)
			}
		set {
			origin.x = newValue.x - (size.width / 2)
			origin.y = newValue.y - (size.height / 2)
		}
	}
}
```
## Shorthand Getter Declaration
If the entire body of a getter is a single expression, the getter implicitly returns that expression. Here’s an another version of the `Rect` structure that takes advantage of this shorthand notation and the shorthand notation for setters:
```swift
struct CompactRect {
	var origin = Point()
	var size = Size()
	var center: Point { 
		get { 
			Point(x: origin.x + (size.width / 2),
			y: origin.y + (size.height / 2))
		}
		set {
			origin.x = newValue.x - (size.width / 2)
			origin.y = newValue.y - (size.height / 2)
		}
	}
}
```
## Read-Only Computed Properties 
A computed property with a getter but no setter is known as a _read-only computed property_. A read-only computed property always returns a value, and can be accessed through dot syntax, but can’t be set to a different value.
- You simply the declaration of a read-only computed property by removing the get keyword and its braces:
```swift
struct Cuboid {
	var width = 0.0, height: 0.0, depth = 0.0
	var volume: Double {
		return width * height * depth
		}
	}
	let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
	print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
	// Prints "the volume of fourByFiveByTwo is 40.0"
```
# Global and Local Variables 
The capabilities described above for computing and observing properties are also available to _global variables_ and _local variables_. Global variables are variables that are defined outside of any function, method, closure, or type context. Local variables are variables that are defined within a function, method, or closure context.

The global and local variables you have encountered in previous chapters have all been _stored variables_. Stored variables, like stored properties, provide storage for a value of a certain type and allow that value to be set and retrieved.

However, you can also define _computed variables_ and define observers for stored variables, in either a global or local scope. Computed variables calculate their value, rather than storing it, and they’re written in the same way as computed properties.

- You can apply property wrappers to a LOCAL stored variable, but NOT a GLOBAL variable or computed variable. 
# Type Properties
Instance properties are properties that belong to an instance of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance.

You can also define properties that belong to the type itself, not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called _type properties_.

Type properties are useful for defining values that are universal to _all_ instances of a particular type, such as a constant property that all instances can use (like a static constant in C), or a variable property that stores a value that’s global to all instances of that type (like a static variable in C).

Stored type properties can be variables or constants. Computed type properties are always declared as variable properties, in the same way as computed instance properties.
