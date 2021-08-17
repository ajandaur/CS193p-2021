//closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context

//Closure Expressiosn: way to write inline closures in a brief, focused syntax
//The Sorted Method
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2:String) -> Bool
{
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)

//Trailing Closures

func someFunctionThatTakesAClosure(closure: () -> Void) {
    //function body goes here
}

someFunctionThatTakesAClosure {
    //code
}

// map() takes a closure expressions as a single argument

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map{ (number) ->
    String in
        var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

//Capturing Values
//A closure can capture constants and variables from the surrounding context in which it is defined
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

//func incrementer() doesn't ahve any parameters, and yet it refers to runningTotal and amount from within its function body
//it does this by capturing a reference to runningTotal and amount from the surrounding function

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

//Closures Are Reference Types
//Whenever you assign a function or a closure to a constant or a variable, you are actually setting
//that constant or variable to be a reference to the function or closure

//Escaping Closures:
// A closure is said to escape a function when the closure is passed as an argument to the function
//but is called after the function returns
var completionHandlers = [() -> Void]()
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

//Autoclosures:
// A closure that is automatically created to wrap an expression that's being passed as an argument to a function. It doesn't take arguments, and when it is called, it returns teh value of the expression that's wrapped inside of it.

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = {
    customersInLine.remove(at: 0)
}
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)

//With @autoclosure, you can call the above function as if it took a String argument instead of a closure

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: customersInLine.remove(at: 0))

//If you want autoclosure that is allowed to escape use both the @autoclosure and the @escaping attributes
