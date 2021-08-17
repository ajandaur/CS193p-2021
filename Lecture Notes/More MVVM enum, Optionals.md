# Enum
- It can only have discrete states ...
```swift
enum FastFoodMenuItem { 
case hamburger(numberOfPatties: Int)
case fries(size: FryOrderSize)
case drink(String, ounces: Int) // the unamed String is the brand
case cookie 
}
```

## Setting the value of an enum
```swift
let menuItem: FastFoodMenuItem = FastFoodMenuItem.hamburger(patties: 2)
var otherItem: FastFoodMenuItem = .cookie
```
## Checking an enum's state
- You can use a switch statement, but you MUST handle ALL POSSIBLE CASES
```swift
var menuItem = FastFoodMenuItem.cookie
switch menuItem {
	case .hamburger: break
	case .fries: print("fries")
	default: print("other")
}
```
- You can also use swittch on any other types, it doesn't have to eb a enum.
## Methods and Properties on an enum
- An enun can have methods and computed properties but NOT STORED PROPERTIES!
- An enum's state is entirely which case it is in and that case's associated data, nothing more
- You can test the enum's state and get its associated data using self:
```swift
enum FastFoodMenuItem {
	...	
	func isIncludedInSpecialOrder(number: Int) -> Bool {
		switch self {
			case .hamburger(let pattyCount): return pattyCount == number
			case .fries, .cookie: return true // a drink and cookie in every special order
			case .drink(_, let ounces): return ounces == 16 // & 16oz drink of any kind
			}
		}
	}
```
- Use _ if we don't care about that piece of associated data.
## Getting all cases of an enumeration
```swift
enum TeslaModel: CaseIterable {
	case X
	case S
	case Three
	case Y
}

for model in TeslaModel.allCases {
	reportSalesNumber(for: model)
}
```

# Optional
 **An Optional is just an enum!**
- Ot can either have: is set(some) or not set(none).
- Declaring something of type Optional(T) can be done with the syntax T? 
	- You can assign it the value nil (Optional.none).
## How to access Optionals 
- You can acces the associated value either by force (with !) 
```swift
let hello: String? = ...
print(hello!) 

switch hello {
	case .none: // raise an exception(crash)
	case .some(let data): print(data)
}
```
- You can also use the more elegant way, "if let"
```swift
if let safehello = hello {
	print(safehello)
} else {
	// do something else
}

switch hello {
	case .none: { // do something else }
	case .some(let data): print(data)
}
```
## Optional defaulting with ?? (nil-coalescing operator)
```swift
let x: String? = ...
let y = x ?? "foo"
```
## Optional chaining
```swift
let x: String? = ...
let y = x?.foo()?.bar?.z
```
- Whenever you hit something that is nil, nil is returned