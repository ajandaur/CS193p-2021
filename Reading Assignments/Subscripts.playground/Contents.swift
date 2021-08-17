// Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence


//Subscript Syntax
struct TimeTable {
    let multipler: Int
    subscript(index: Int) -> Int {
        return multipler * index
    }
}
let threeTimesTable = TimeTable(multipler: 3)
print("six times three is \(threeTimesTable[6])")

//Subscript Usage: shortcut for accessing the member elements in a collectio, list, or sequence
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

//Subscript Options
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool
    {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

//Type Subscripts:
 enum Planet: Int {
     case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
     static subscript(n: Int) -> Planet {
         return Planet(rawValue: n)!
     }
 }
 let mars = Planet[4]
 print(mars)
