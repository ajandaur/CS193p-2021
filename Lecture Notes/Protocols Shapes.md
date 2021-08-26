# Protocols 
- sort of a "stripped-down" struct/class
```swift
protocol Moveable { 
	func move(by: Int)
	var hasMoved: Bool { get }
	var distanceFromStart: Int { get set }
}
```
## Protocol Inheritance
```swift
protocol Vehicle: Moveable { 
	var passengerCount: Int { get set }
}
```
- You can implement multiple protocols 
# What is a protocol used for
- Very rarely used as a type 
- Use them more commonly to specify the behavior of a struct, class, or enum.
- Another way is to turn a generic t oa "care kind of"
```swift
struct MemoryGame<CardContent> where CardContent: Equatable
```
- This is the heart of protocol-oriented programming
- Can also use protocols to restrict an extension to work only with certain things
```swift
extension Array where Element: Hashable { ... }
```
- You can use individual functions to work with certain things
- Occasionally a protocol is used to set up an agreement between two entities
- You can use them for code sharing
	- **Implementations can be added to a protcol by creating an extension to it**
# Adding protocol implementation
- Think of protocols as constrains and gains 
```swift
struct Tesla: Vehicle {
	// Tesla is constrained to have to implement everything in Vehicle
	// but it gains all the capabilities a Vehicle has too
}
```
# Generics + Protcols 
```swift
protocol Identifiable {
	var id: ID { get }
}
```
- The type ID here is "don't care" for Identifiable
- Protocols can be generics too!
# Hashable
- Simple protocol..
```swift
protocol Hashable {
	func hash(into hasher: inout Haser) // a Hasher just has a combine(...) func on it
}
```
- If you hash something nad use tht hash to look it up in a hash table, then you have to be able to then use == on the thing to make sure it's the same thing you hashed
- Therefore, things that are Hashable but also be Equatable!
# Equatable
- Things that "behave like" Equatable can be compared with == 
- Swift knows to call this static function in the Equatable protocol when you do == ... 
# Shapes
- Shapes draw themselves by filling with the current foreground color.
- This can be changed with .stroke() and .fill()
- They return a View that drwas the Shape in the specified way
## Creating your own shape
```swift
func path(in rect: CGRect) -> Path {
	return a Path
}
```
