# Collections of Identifiables 
- In Memorize and Set we had to do: 
```swift
func choose(_ card: Card) {
	if let index = cards.firstIndex(where: { $0.id == card. id }) { 
	cards[index].isFaceUp = true 
	}
}
```
- This is is because Card is a struct and structs are VALUE TYPES -> VALUE TYPES GET COPIED 
- To change isFaceUp of one of our game's cards, we need to change it in our Array

- We can make a function that is better than firstIndex by putting an extension to the Array type
**- index(matching): can also be useful in Set (which might be useful in Assignment #5)**

 - Something better is to add index(matching: ) to the Collection protocol
 ```swift
 extension Collection where Element: Identifiable { 
 	func index(matching element: Element) -> Self.Index? { 
		firstIndex(where: { $0.id == element.id })
		}
	}
 ```
 - Since Array and Set both conform to Collection, not will get index(matching: )

- You can also extend a function like remove(_ element: Element)
```swift
extension Collection where Element: Identifiable { 
	mutating func remove(_ element: Element) {
		if let index = index(matching: element) { 
			remove(at: index) 
			}
		}
	}
```
- This is not possible, you must use the mutable Collection protocol called RangeReplaceableCollection
## Using subscripting 
- You can enable subscripting of an Array or Set of Identifiables to be an Identifiable 
## Color 
- Is a color-specifier -> .foregroundColor(Color.green)
- also act like a ShapeStyle -> .fill(Color.blue)
- can also act like a view -> Color.white can appear whereever a View can appear
## UIColor 
- More API for manipulating colors
- More built-in colors 
- Can be converted between color spaces ( RGB vs HSB)
- Once you have a desired UIColor, you can use Color(uiColor: ) to use it in one of teh roles above
## CGColor
- **The fundamental color represnetation in the Core Graphics drawing system**
- Color might be able to give a CGColor represntation of itself (color.cgColor is optional)
## Image
- Primarly serves as a View 
- It is not a type for vars that hold an image -> that is **UImage**
- Access images via the Assets.xcassets by name using Image(_ name: String)
- You can create SF Symbol images using Image(systemName: )
- You can control the size of system Images with **imageScale()** View modifier
- You can also use the .font modifier
- System Images can also be very useful as masks (for gradients, for example)
 ## UIImage 
 - Is the type for actually creating/manipulating images and storing in vars 
 - Very powerful for representing an image 
 - Once you have the UImage you want, you can use Image(uiImge: ) to display it 
 # Drag and Drop
 ## Item Provider 
 - the heart of drag and drog is the **NSItemProvider** class
 - It facilitates the transfer of data between processes (via drag and drop, for example) 
 - NSItemProvider facilitates the transfer of a number of data types like
	 - NSAttributedString
	 - NSURL
	 - UIImage and UIColor 
 - All of these NS things are pre-Swift 
 - we need to bridge Swift with the NS-world things 
 - we will do this via "String as NSString"
 
 # Multithreading
 ## Don't block my UI
 - It is never okay for your UI to be unresponsive
 - How do we keep our UI responsive when these long-lived taks are going on? -> execute the CPU heavy thing or access the network on a different "thread of execution"
 ## Queues
 - The challenge is to make multithreading code authorable, readable, and understandable
 - This adds a "fourth dimenson" -> this is solved via queues
 - You don't worry about threads in Swift, we worry about queues! 
 ## Queues and Closures 
 - We specify the blocks of code using closures
 ## Main Queue
 - This is the most important queue -> Has all the blocks of queue that might muck with the UI
 - Any time we want to do something in the UI, we must use this queue! 
 - It is an error to do UI (directly or indrectiy) OFF the main queue
 ## Background Queues
 - This is where you do long-lived, non-UI tasks
 - There are a bunch of threads for this, so you can run things in parallel 
 - The main queue will always be higher priority than any of the background queues
 ## GCD (Grand Central Dispatch)
 - Two fundamental tasks for the GCD are..
	 1. Getting access to the queue 
	 2. Plopping a block of code on the queue
- You use DispatchQueue.main to get the main queue
- You use DispatchQueue.global(qos: QoS) to get the background queue
- qos (quality of service) can be one of the following:
	1. .** .userInteractive (do this fast, the UI depends on it!)**
	2. .userInitiated (the use just asked to do this, so do it now)
	3. .utility (thisneeds to happen, but the user didn't just ask for it)
	4. .background (maintenance tasks (cleanups, etc.) )

## Plopping a Closure onto a Queue
- Two basic ways after doing: Let queue = DispatchQueue.main or DispatchQueue.global(qos: )
	1. call queue.async { }
	2. call queue.sync { }
- The second one BLOCKS waiting for that closure to be picked off by its queue and completed. You would NEVER call .async in UI code
- You would most likely call it on a background queue ( to wait for some UI to finish, for example) But even that is rare..
**- Most of the time you are going to use .async ** -> .async will execute that closure "sometime later"
- There are also delays for the time before executing a block of code on the queue
## Nesting 
- Ex. -> DispatchQueue(global: .userInitiated).async {  } -> WILL NOT block the UI because it is happening off the main queue
- To change the UI, use nesting where you plop a closure with the UI code we want onto the main queue
## Asynchronous API
- You will use DispatchQueue.main.async{ } often when programming asynchronously in iOS