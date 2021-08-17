# Mutability of Collections
- Three types: **arrays, sets, and dictionaries.**
	- Arrays are ordered collections of values. 
	- Sets are unordered collections of unique values. 
	- Dictionaries are unordered collections of key-value associations.
# Arrays
## Creating an Array with a Default Value
```swift
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
```
 You can create a new array by adding together two existing arrays with compatible types with the addition operator (`+`).
 
 If you want to remove the final item from an array, use the `removeLast()` method rather than the `remove(at:)` method to avoid the need to query the array’s `count` property. Like the `remove(at:)` method, `removeLast()` returns the removed item:
 ```swift
 let apples = shoppingList.removeLast()
// the last item in the array has just been removed
// shoppingList now contains 5 items, and no apples
// the apples constant is now equal to the removed "Apples" string
 ```
 If you need the integer index of each item as well as its value, use the `enumerated()` method to iterate over the array instead. For each item in the array, the `enumerated()` method returns a tuple composed of an integer and the item. The integers start at zero and count up by one for each item; if you enumerate over a whole array, these integers match the items’ indices.
 # Sets 
 A _set_ stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.
 - A type must be HASHABLE in order to be store in a set. In other words, the type must provide a way to compute a hash value for itself
 - String, Int, Double, and Bool are hashable by default, and can be used as set valuves types of dictionary key types
 -  Enumeration case values without associated values (as described in [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)) are also hashable by default.
## Creating and Initializing an Empty Set
```swift
var letters = Set<Character>()
print("Letters is of type Set<Character> with \(letters.count) items.")
// Prints "letters is of type Set<Character> with 0 items"
```
# Performing Set Operations
You can efficiently perform fundamental set operations, such as combining two sets together, determining which values two sets have in common, or determining whether two sets contain all, some, or none of the same values.

# Dictionaries
A _dictionary_ stores associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value is associated with a unique _key_, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary don’t have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.
## Iterating Over a Dictionary
You can iterate over the key-value pairs in a dictionary with a `for`-`in` loop. Each item in the dictionary is returned as a `(key, value)` tuple, and you can decompose the tuple’s members into temporary constants or variables as part of the iteration:
```swift
for (airportCode, airportName) in airports {
print("\(airportCode): \(airportName)")
}
```
