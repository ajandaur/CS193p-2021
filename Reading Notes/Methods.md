_Methods_ are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself. Type methods are similar to class methods in Objective-C.

The fact that structures and enumerations can define methods in Swift is a major difference from C and Objective-C. In Objective-C, classes are the only types that can define methods. In Swift, you can choose whether to define a class, structure, or enumeration, and still have the flexibility to define methods on the type you create.
## Instance Methods
_nstance methods_ are functions that belong to instances of a particular class, structure, or enumeration. They support the functionality of those instances, either by providing ways to access and modify instance properties, or by providing functionality related to the instance’s purpose. Instance methods have exactly the same syntax as functions, as described in [Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html).

You write an instance method within the opening and closing braces of the type it belongs to. An instance method has implicit access to all other instance methods and properties of that type. An instance method can be called only on a specific instance of the type it belongs to. It can’t be called in isolation without an existing instance.
## The self property
- Understand that self is just referring to the instance itself.
- But thankfully, you don't need to write self in your code very often, Swift will assume that you are referring to a property or moethod of the current instance whenever you use a known property or method name within a method.

## Modifying Value Types from Within Instance Methods
- Remember, structures and functions are VALUE TYPES!
- Properties of a value type CANNOT be modified from within its instance methods

However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to _mutating_ behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit `self` property, and this new instance will replace the existing one when the method ends.

Note that you CANNOT call mutating method on a constant of structure type, because its properties can't be changed, even if they're variable properties! 
## Assigning to self within a Mutating Method
Mutating methods can assign an entirely new instance to the implicit `self` property. The `Point` example shown above could have been written in the following way instead:
```swift
struct Point { 
	var x = 0.0, y = 0.0
	mutating func moveBy(x deltaX: Double, y deltaY: Double) {
		self = Point(x: x + deltaX, y: y +deltaY)
		}
	}
```
This version of the mutating `moveBy(x:y:)` method creates a new structure whose `x` and `y` values are set to the target location. The end result of calling this alternative version of the method will be exactly the same as for calling the earlier version.

Mutating methods for enumerations can set the implicit `self` parameter to be a different case from the same enumeration:
```swift
enum TriStateSwitch { 
	case off, low, high
	mutating func next() {
		switch self {
		case .off:
			self = .low
		case .low:
			self = .high
		case .high:
			self = .low
			}
		}
	}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight = .high
ovenLight.next()
// ovenLight = .off
```
# Type Methods
Instance methods, as described above, are methods that you call on an instance of a particular type. You can also define methods that are called on the type itself. These kinds of methods are called _type methods_. You indicate type methods by writing the `static` keyword before the method’s `func` keyword. Classes can use the `class`keyword instead, to allow subclasses to override the superclass’s implementation of that method.