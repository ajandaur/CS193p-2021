//three primary collection types, known as arrays, sets, and dictionaries
//arrays are ordered collections of values
//sets are unordered collections of unique values
//dictionaries are unordered collection of key-value associations

//Arrays

var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)

var threeDoubles = Array(repeating: 0.0, count: 3)

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)

var sixDoubles = threeDoubles + anotherThreeDoubles

var shoppingList = ["Eggs","Milk"]

//Accessing and modifying an array

print("The shopping list contain \(shoppingList.count) items.")

if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty")
}

shoppingList.append("Flour")

shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese","Butter"]
var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList.insert("Maple Syrup", at: 0)
let mapleSyrup = shoppingList.remove(at: 0)
firstItem = shoppingList[0]
let apples = shoppingList.removeLast()

//iterating over an array
for item in shoppingList {
    print(item)
}

for (index,value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

//Sets
var letters = Set<Character>()
print("letters of type Set<Character> with \(letters.count) items.")
letters.insert("a")
letters = []
var favoriteGenres: Set = ["Rock","Classical","Hip hop"]
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

for genre in favoriteGenres {
    print("\(genre)")
}
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sorted()
oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
farmAnimals.isSuperset(of: houseAnimals)
farmAnimals.isDisjoint(with: cityAnimals)

//Dictionaries
var nameOfIntegers = [Int: String]()
nameOfIntegers[16] = "sixteen"
nameOfIntegers = [:]

var airports = ["YYZ":"Toronto Pearson", "DUB":"Dublin"]
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"

if let oldValue =
    airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("THe airport is not in the airports dictionary")
}

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The remove airport's name is \(removedValue)")
} else {
    print("The airports dictionary does not contain avalue for DUB.")
}

//iterating over a dictionary
for (airportCode, airportName) in airports {
    print("\(airportCode) : \(airportName)")
}



