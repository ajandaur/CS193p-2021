//An enumeration defines a common type for a group of related values nad enables you to work with those values in a type-safe way within your code

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, uranus, neptume
}

var directionToHead = CompassPoint.west
directionToHead = .east

//Matching Enumeration Values with a Switch Statement
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("mostly harmless")
default:
    print("Not a safe place for humans")
}

//Iterating over Enumeration Cases
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

//Associated Values: storing values of other types alongside these case values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

//crate barcodes using either type
var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//can store only one of them at any given time

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode): print("QR code: \(productCode).")
}

//if all associated values or constants or varivles you can place a single var/let before case number for brevity!

//Raw Values: default values which are all the same type
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//Raw values can be strings, characters, or any of the interger or floating-point number types
enum PlanetRefined: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPointRefined: String {
    case north, south, east, west
}

let earthsOrder = PlanetRefined.earth.rawValue
let sunsetDirection = CompassPointRefined.west.rawValue

//Initializing Raw Value
let possiblePlanet = PlanetRefined(rawValue: 7)
//returns an optional enumeration because not all possible Int values will find a matching planet
let positionToFind = 11
if let somePlanet = PlanetRefined(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
        default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//Recursive Enumerations: enumeration that has another instance of the enumeration as the associated value for one or more the enumeration cases
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))

