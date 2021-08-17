//Optional Chaining as an Alternative to Forced Unwrapping

class Person
{
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence() //johhn.residence now contains an actual Residence instance, rather than nil.

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."
//Above now returns an Int? that contains a default numberOfRooms value of 1.


//If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining.
//If the type you are trying to retrieve is already optional, it will not become more optional because of the chaining.




