# @State 
- Your View is only Read Only
- The exception to the rule above are **Property Wrappers**
## Why Though??
- Views are created and tossed out all the time 
- Only the "bodies" stick around
- Views are supposed to be "stateless'", we only care about drawing stuff from the model
## When Views need State
- When we want storage of things temporary
	- Examples:
		- Entered "an editing mode" and are collecting changes in preparation for an Intent
		- Displaying another View to gather information or notify the user
		- want an animation to kick off an want to track the end point
- All these @State are considered private 
- Changes to @State var will cause the View to rebuild its body! (This is expected..)
- It is kind of like @ObservedObject but for a random piece of data instead of the ViewModel
## How it works..
@State private var something Temporary: SomeType
- This is going to make some space in the heap 
- When your read-only View gets rebuilt, the new version will continue to point to it
- Changes to your View (via its arguement) will not dump this state
- use @State sparingly!

# Property Observers
- Are essentially a way to "watch" a var and execute code when it changes
```swift
var isFaceUp: Bool {
	willSet {
		if newValue {
			startUsingBonusTime()
		} else {
			stopUsingBonusTime()
			}
		}
	}
```
Inside here, newValue is a special variable (the value it's going to get set to).
There's also didSet (inside this one, oldValue is what the value used to be).
# Layout 
## How is the space on-screen apportioned to the Views??
- Simple process
	1. Contain Views "offer" space to the Views inside them
	2. Views then choose what size they want to be
	3. Container Views then position the Views inside of them
	4. (and based on that, Container Views choose their own size as per #2 above)
## HStack and VStack 
- Stacks divide up the space that is offered to them and then offer that to the Views inside -> **It offers space to its "least flexibe" (with respect to sizing) subviews first**
	- Examples: Images, Text, RoundedRectangle
- After an offered Views(s) takes what it wants, its size is removed from the space available.
- Then the stack moves on the next "LEAST FLEXIBLE" Views
- Very flexible views (those that will take all offered space) will share evenly (mostly). Rinse and repeat! 
- **If any of the views are "VERY FLEXIBLE"**, the H-stack and V-stack themselves will become very flexible
	- **Spacer**: always takes all the space offered to it. Draws nothing. 
	- **Divider**: draws a dividing line cross-wise to the way the stack is laying out 
- Stack's choice of who to offer space to next can be overridden with .layoutPriority(Double). In other words, layoutPriority trumps "least flexible"
```swift
HStack {
	Text("Important").layoutPriority(100) // any floating number is okay
	Image(systemName: "arrow.up") // the default layout priority is 0
	Text("Unimportant")
}
```
### Alignment for HStack and VStack
- When a VStack lays Views out in a column, what if the Views are not all the same width??
There is a specific argument to the stack ...
```swift
VStack(alignment: .leading) { . . . }
```
Why .leading instead of .left? 
- some languages are written right to left

## LazyHStack and LazyVStack
- These "lazy" versions of the stack don't build any of their Views that are NOT visible
- They also size themselves to fit their Views
## ScrollView
- ScrollView takes all the space offered to it
- The views inside it are sized to fit along the axis your scrolling on
## LazyHGrid and LazyVGrid 
## List and Form and Outline Group
- sort of like "really smart VStacks"
## ZStack
- Sizes itself to fit its children
- If even one of its children is fully flexible size, then the ZStack will be too.
## .background modifier
```swift
Text("hello").background(Rectangle().foregroundColor(.red))
```
## .overlay modifier
- Same layout rules as .background, but stacked the other way around.
```swift
Circle().overlay(Text("Hello"), alignment: .center)
```
## Modifiers
- View modifier functioons return a View themselves
- That view "contains" the View it's modifying
- Many of them just pass the size offered to them along. But it is possible for a modifier to be involved in the layout process itself
### Example
```swift
HStack {
	ForEach(viewModel.cards) { cards in 
		CardView(card: card).aspectRatio(2/3, contentMode: .fit)
		}
	}
		.foregroundColor(Color.orange)
		.padding(10)
```
# Geometry Reader
- You wrap this GeometryReader View around would normally appear in your View's body... 
```swift
var body: View {
	GeometryReader { geometry in 
	. . .
	}
}
```
**GeometryReader itself It's just aView) ALWAYS accepts all the space offered to it.**
## Safe Area 
- When a View is offered space, that space DOES NOT include "safe areas"
- Obvious "safe area" -> notcho n an iPhone X. 
- Surrounding Views might also introduce "safe areas" that Views inside shouldn't draw in
- To ignore and draw in areas anyways on specified edges:
```swift
ZStack { }.edgesIgnoringSafeAreaS([/.top]) // draw in "safe area" on top edge
```
# @ViewBuilder
- You can apply it to any of their functions that return something that conforms to View
- If applied, the function still returns something that conforms to View
- But it will do so by interpreting the contents as a list of Views and combines them into one
- You se can use @ViewBuilder to mark a parameter of a function or an init
- That arguement's type must be "**a function that returns a View**"