//Methods

//Instance Methods

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

//Modifying Value Types from Within Instance Methods

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"

//Assigning to self Within a Mutating Method

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()

//Type Methods
class SomeClass {
    class func someTypeMethod() {
        
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool
    {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.isUnlocked(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// Prints "level 6 has not yet been unlocked"
