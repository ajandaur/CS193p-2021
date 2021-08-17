_Initialization_ is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.

You implement this initialization process by defining _initializers_, which are like special methods that can be called to create a new instance of a particular type. Unlike Objective-C initializers, Swift initializers don’t return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.

Instances of class types can also implement a _deinitializer_, which performs any custom cleanup just before an instance of that class is deallocated. For more information about deinitializers, see [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html).
## Setting Initial Values for Stored Properties
Classes and structures _must_ set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state.

You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property’s definition. These actions are described in the following sections.
### Initializers
_Initializers_ are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, written using the `init`keyword:
```swift
init() {
	// perform some initialization here
}
```
### Default Property Values
You can set the initial value of a stored property from within an initializer, as shown above. Alternatively, specify a _default property value_ as part of the property’s declaration. You specify a default property value by assigning an initial value to the property when it’s defined.
# Customizing Initialization
You can customize the initialization process with input parameters and optional property types, or by assigning constant properties during initialization, as described in the following sections.

## Initialization Parameters

You can provide _initialization parameters_ as part of an initializer’s definition, to define the types and names of values that customize the initialization process. Initialization parameters have the same capabilities and syntax as function and method parameters.

## Initializer Parameters Without Argument Labels
If you don’t want to use an argument label for an initializer parameter, write an underscore (`_`) instead of an explicit argument label for that parameter to override the default behavior.

## Optional Property Types
If your custom type has a stored property that’s logically allowed to have “no value”—perhaps because its value can’t be set during initialization, or because it’s allowed to have “no value” at some later point—declare the property with an _optional_ type. Properties of optional type are automatically initialized with a value of `nil`, indicating that the property is deliberately intended to have “no value yet” during initialization.

The following example defines a class called `SurveyQuestion`, with an optional `String`property called `response`:
```swift 
class SurveyQuestion { 
	var text: String
	var response: String?
	init(text: String) {
		self.text = text
		}
		func ask() {
			print(text)
		}
	}
	let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
	cheeseQuestion.ask()
	// Prints "Do you like cheese?"
	cheeseQuestion.response = "Yes, I do like cheese."
```
The response to a survey question can’t be known until it’s asked, and so the `response`property is declared with a type of `String?`, or “optional `String`”. It’s automatically assigned a default value of `nil`, meaning “no string yet”, when a new instance of `SurveyQuestion` is initialized.
# Default Initializers
Swift provides a _default initializer_ for any structure or class that provides default values for all of its properties and doesn’t provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.
## Memberwise Initializers for Structure Types
Structure types automatically receive a _memberwise initializer_ if they don’t define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.

The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.

The example below defines a structure called `Size` with two properties called `width`and `height`. Both properties are inferred to be of type `Double` by assigning a default value of `0.0`.

The `Size` structure automatically receives an `init(width:height:)` memberwise initializer, which you can use to initialize a new `Size` instance:
```swift
struct Size {
	var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```
When you call a memberwise initializer, you can omit values for any properties that have default values. In the example above, the `Size` structure has a default value for both its `height` and `width` properties. You can omit either property or both properties, and the initializer uses the default value for anything you omit—for example:
```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"
```
# Initializer Delegation for Value Types
Initializers can call other initializers to perform part of an instance’s initialization. This process, known as _initializer delegation_, avoids duplicating code across multiple initializers.

The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) don’t support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, as described in [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html). This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization. These responsibilities are described in [Class Inheritance and Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID216) below.

- Value types; use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.
- If you define a custom initailizer for a value type = you can no longer have access to the DEFAULT inializer (or the memberwise initializer, if it's a struct) for that type

The following example defines a custom `Rect` structure to represent a geometric rectangle. The example requires two supporting structures called `Size` and `Point`, both of which provide default values of `0.0` for all of their properties:
```swift
struct Size {
	var width = 0.0, height = 0.0
}
struct Point {
	var x = 0.0, y = 0.0
}
```
You can initialize the `Rect` structure below in one of three ways—by using its default zero-initialized `origin` and `size` property values, by providing a specific origin point and size, or by providing a specific center point and size. These initialization options are represented by three custom initializers that are part of the `Rect` structure’s definition:
```swift
struct Rect {
	var origin = Point()
	var size = Size()
	init() {}
	init(origin: Point, size: Size) {
		self.origin = origin
		self.size = size
	}
	init(center: Point, size: Size) {
		let originX = center.x - (size.width / 2)
		let originY = center.y - (size.height / 2)
		self.init(origin: Point(x: originX, y: originY), size: size)
		}
	}	
```
The first `Rect` initializer, `init()`, is functionally the same as the default initializer that the structure would have received if it didn’t have its own custom initializers. This initializer has an empty body, represented by an empty pair of curly braces `{}`. Calling this initializer returns a `Rect` instance whose `origin` and `size` properties are both initialized with the default values of `Point(x: 0.0, y: 0.0)` and `Size(width: 0.0, height: 0.0)` from their property definitions:
```swift
let basicRect = Rect() 
// basicRect's origin is (0.0, 0,0) and its size is (0.0, 0.0)
```
The second `Rect` initializer, `init(origin:size:)`, is functionally the same as the memberwise initializer that the structure would have received if it didn’t have its own custom initializers. This initializer simply assigns the `origin` and `size` argument values to the appropriate stored properties:
```swift
let originRect = Rect(origin: Point(x: 2,0, y: 2.0), size: Size(width: 5.0, height: 5.0))
// originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)
```
The third `Rect` initializer, `init(center:size:)`, is slightly more complex. It starts by calculating an appropriate origin point based on a `center` point and a `size` value. It then calls (or _delegates_) to the `init(origin:size:)` initializer, which stores the new origin and size values in the appropriate properties:
```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
```
The `init(center:size:)` initializer could have assigned the new values of `origin` and `size` to the appropriate properties itself. However, it’s more convenient (and clearer in intent) for the `init(center:size:)` initializer to take advantage of an existing initializer that already provides exactly that functionality.
# Setting a Default Property Value with a Closure or Function
If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property. Whenever a new instance of the type that the property belongs to is initialized, the closure or function is called, and its return value is assigned as the property’s default value.

These kinds of closures or functions typically create a temporary value of the same type as the property, tailor that value to represent the desired initial state, and then return that temporary value to be used as the property’s default value.

Here’s a skeleton outline of how a closure can be used to provide a default property value:
```swift
class SomeClass {
	let someProperty: SomeType = {
		// create a default value for someProperty inside this closure
		// someValue must be f the same type as SomeType 
		return someValue
	}()
}
```
Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.