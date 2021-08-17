# Comparing Structures and Classes 
Structures and classes in Swift have many things in common. Both can:

-   Define properties to store values
-   Define methods to provide functionality
-   Define subscripts to provide access to their values using subscript syntax
-   Define initializers to set up their initial state
-   Be extended to expand their functionality beyond a default implementation
-   Conform to protocols to provide standard functionality of a certain kind

For more information, see [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html), [Methods](https://docs.swift.org/swift-book/LanguageGuide/Methods.html), [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html), [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html), [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html), and [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html).

Classes have additional capabilities that structures don’t have:

-   Inheritance enables one class to inherit the characteristics of another.
-   Type casting enables you to check and interpret the type of a class instance at runtime.
-   Deinitializers enable an instance of a class to free up any resources it has assigned.
-   Reference counting allows more than one reference to a class instance.

For more information, see [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html), [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html), [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html), and [Automatic Reference Counting](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html).

The additional capabilities that classes support come at the cost of increased complexity. As a general guideline, prefer structures because they’re easier to reason about, and use classes when they’re appropriate or necessary. In practice, this means most of the custom data types you define will be structures and enumerations. For a more detailed comparison, see [Choosing Between Structures and Classes](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes).

# Structures and Enumerations Are Value Types 
A _value type_ is a type whose value is _copied_ when it’s assigned to a variable or constant, or when it’s passed to a function.

You’ve actually been using value types extensively throughout the previous chapters. In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.

All structures and enumerations are value types in Swift. This means that any structure and enumeration instances you create—and any value types they have as properties—are always copied when they’re passed around in your code.
# Classes Are Reference Types
Unlike value types, _reference types_ are _not_ copied when they’re assigned to a variable or constant, or when they’re passed to a function. Rather than a copy, a reference to the same existing instance is used.