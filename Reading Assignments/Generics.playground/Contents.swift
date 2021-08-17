//Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

//The Problem That Generics Solve
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

func swapTwoStrings(_ a: inout String, _ b: inout String)
{
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//Better to write a single function that swaps two values of ANY type --> Generics!

//Generic Functions
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//use a placeholder type name instead of an actualy type name
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"

//Type Parameters
//placeholder type T is an example of a type parameter

//Generic Types: define your own generic types
//Stack: an ordered set of values, similar to an array, but with a more restricted set of operations than Swift's Array type

//struct IntStack {
//    var items = [Int]()
//    mutating func push(_ item: Int) {
//        items.append(item)
//    }
//    mutating func pop() -> Int {
//        return items.removeLast()
//    }
//}

//struct Stack<Element> {
//    var items = [Element]()
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//}

var stackOfString = Stack<String>()
stackOfString.push("uno")
stackOfString.push("dos")
stackOfString.push("tres")
stackOfString.push("cuatro")

let fromTheTop = stackOfString.pop()

//Extending a Generic Type
// When you extend a generic type, you don't provide a type parameter list as part of the extension's definition
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfString.topItem {
    print("The top item on the stack is \(topItem).")
}

//Type Constraints
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated()
    {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Prints "The index of llama is 2"

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated()
    {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])

//Associated Types
//When defining a protocol, it's sometimes useful to declare one or more associated types as part of the protocol's definition

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//This protocol doesn’t specify how the items in the container should be stored or what type they’re allowed to be. The protocol only specifies the three bits of functionality that any type must provide in order to be considered a Container. A conforming type can provide additional functionality, as long as it satisfies these three requirements.

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    //conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    //conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
//Element is used as the type of the append(_:) method's item paarameter and the return tye pf the subscript, therefore Swift can infer that Element is the appropriate type to use as the Item for this particular container

//Extending an Existing Type to Specify an Associated Type
extension Array: Container {}

//Adding Constraints to an Associated Type

//protocol Container {
//    associatedtype Item: Equatable
//    mutating func append(_ item: Item)
//    var count: Int { get }
//    subscript(i: Int) -> Item { get }
//}

//To conform to this version of Container, the container’s Item type has to conform to the Equatable protocol.

//Using a Protocol in Its Associated Type's Constraints

protocol SuffixableContainer : Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

//Suffix has two constraints: It must conform to the SuffixableContainer protocol (the protocol currently being defined), and its Item type must be the same as the container’s Item type.

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack
}
var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
//suffix contains 20 and 30

extension IntStack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack<Int> {
        var result = Stack<Int>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    //Inferred that Suffix is Stack<Int>
}

//Generic Where Clauses
//A generic where caluse enables you to require that an associated types must be the same.
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    //Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }
    //Check each pair of items to see if they're equivalent
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    //all items match, so return true
    return true
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// Prints "All items match."

//Extension with a Generic Where Clause
// You can also use a generic where clause as part of an extension.

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}
//Prints "Top element is tres."

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())
// Prints "648.9"


