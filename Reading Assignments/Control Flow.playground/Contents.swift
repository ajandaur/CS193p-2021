//Control Flow

let minutes = 60
for tickMark in 0..<minutes {
    
}

let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, to: hours, by: hourInterval) {
    
}

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1}
    square += diceRoll
    if square < board.count {
        square += board[square]
    }
}

//conditional statements

var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}

//switch statement must be exhaustive
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("some other character")
}
//Prints "The last letter of the alphabet"

//interval matching
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

//tuples
let somePoint = (1,1)
switch somePoint {
case (0,0):
    print("\(somePoint) is at the origin")
case(_,0):
    print("\(somePoint) is on the x-axis")
case(0,_):
    print("\(somePoint) is on the y-axis")
case(-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside the box")
}

//Control transfer statements change the order in which your code is executed:

//continue
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a","e","i","o","u"," "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)

// use break statement to ignore a switch case

//Early Exit
//use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"]
        else {
            print("I hope the weather is nice near you.")
            return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])

//Checking API Availability
