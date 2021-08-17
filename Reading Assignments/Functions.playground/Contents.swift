
//Omitting ARgument Labels --> if you don't want to use an argument label for a parameter, write an underscore _ instead of explicit argument label for the parameter
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    }
someFunction(1, secondParameterName: 2)

//variadic parameters accepts ero or more values of a specified type
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total/Double(numbers.count)
}

arithmeticMean(1,2,3,4,5)

//in-out function
func swapTwoInts(_ a: inout Int, _ b: inout Int)
{
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)

