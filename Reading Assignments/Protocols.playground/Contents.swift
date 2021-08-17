import Foundation
//Property Requirements
//protocols defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality
//A protocol can require any conforming type to provide an instance property or type property with a particular name and type.

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}


protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"


//Method Requirements
protocol SomeProtocol2 {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator:
    RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
        
    .truncatingRemainder(dividingBy: m))
        return lastRandom / m
        }
    }
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

//Mutating Method Requirements
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

//Initializer Requirements
protocol SomeProtocol3 {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol3 {
    required init(someParameter: Int) {
        //code
    }
}

//Protocols as Types
//sometimes called an existential type

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

//Delegation: a design pattern that enables a class or structure to hand off some of its responsibilities to an instance of another type.

protocol DiceGame {
    var dice: Dice { get }
    func play ()
}
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

//DiceGame protocol is a protocol that can be adopted by any game that involves dice

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
             board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where
                newSquare > finalSquare:
                continue gameLoop
            default: square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
          print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

//Adding Protocol Conformance with an Extension

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

//Conditionally Conforming to a Protocol
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map {
            $0.textualDescription
        }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)

//Declaring Protocol Adoption with an Extension
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

//Types don’t automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.

//Adoptiing a Protocol Using a Synthesized Implementation
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

//Collections of Protocol Types
let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}

//thing constant is of type TextRepresentable

//Protocol Inheritance: a protocol can inherit one or more other protocols and can add further requirements on top of requirements it inherits

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

//Class-Only Protocols: limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol's inheritance list.

//Protocol Composition: you can combine multiple protocols into a single requirement with a protocol composition
//protocol compositions don't define any new protocol types
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Prints "Happy birthday, Malcolm, you're 21!"

//example that combines the Named protocol from the previous example with a Location class
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double)
    {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

//Checking for Protocol Conformance
//you can use is and as operators in Type Casting to check for protocol conformance, and to cast to specific protocl
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) {
        self.radius = radius
    }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) {self.legs = legs }
}
//Below, these classes don't share a base class, therefore they store values of type AnyObject
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

//check to see if it conforms to protocol of HasArea
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//Note that the underlying objects aren’t changed by the casting process. They continue to be a Circle, a Country and an Animal. However, at the point that they’re stored in the objectWithArea constant, they’re only known to be of type HasArea, and so only their area property can be accessed.

//Optional Protocol Requirements
// You can define optional requirements for ptocols. They are prefixed by the optional modifier as part of the protocol's definition
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//Protocol Extensions
//Protocols can be extended to provide method, initializer, subscript, and computed property implemenations to conforming types
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And here's a random Boolean: \(generator.randomBool())")
// Prints "And here's a random Boolean: true"

//Providing Default Implementations
//If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//Adding Constraints to Protocol Extensions
//When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending by writing a generic where clause. For more about generic where clauses, see Generic Where Clauses.

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

print(equalNumbers.allEqual())
// Prints "true"
print(differentNumbers.allEqual())
// Prints "false"



