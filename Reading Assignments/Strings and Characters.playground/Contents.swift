//String Literals

let someString = "Some string literal value"

let quotation = """
The White Rabbit put on his spectacles.
"Where shall I begin, please your Majesty?" he asked.

"""

//Initializing an Empty String
var emptyString = ""
var anotherEmptyString = String()
if emptyString.isEmpty {
    print("Nothing to see here")
}

//String mutability
var variableString = "Horse"
variableString += " and carriage"

//Working with Characters
for character in "Dog!🐶" {
    print(character)
}

let exclamationMark: Character = "!"

let catCharacters: [Character] = ["C","a","t","!","😸"]
let catString = String(catCharacters)
print(catString)

//Concatenating STrings and Characters
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

welcome.append(exclamationMark) //you can append Character value to String variable with append() method

let goodStart = """
one
two

"""

let end = """
three
"""
print(goodStart + end)

//Counting Characters
let unusualMenagerie = "Koala, Snail, Pengiun, Dromedary"
print("unusualMenagerie has \(unusualMenagerie.count) characters")

//Accessing and Modifying a String
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
//Which types are part of the Collection protocol?? String, Array, Dictionary, Set

var welcome1 = "hello"
welcome1.insert("!", at: welcome1.endIndex)

welcome1.insert(contentsOf: " there", at: welcome1.index(before: welcome1.endIndex))

//removing
welcome.remove(at: welcome.index(before: welcome.endIndex))
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)

//you can use above methods on any type that conforms to RangeReplaceableCollection protocol

//Substrings
let greeting1 = "Hello, world"
let index1 = greeting1.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting1[..<index1]
let newString = String(beginning)

//comparing strings

let quotation1 = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation1 == sameQuotation {
    print("These two strings are considered equal")
}


let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")

//hasSuffix() method to count the number of scenes that take place in or around Capulet's masions and Friar Lwrence's cell:

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion")
    {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}

print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

