# Property Wrappers
- All of those @Something are called **property wrappers**
- They are just structs that encapsulate some "template behavior" applied to the vars they wrap
- Examples:
	- @State
	- @Published
	- @ObservedObject
## Property Wrapper Syntactic Sugar
```swift
@Published var emojiArt: EmojiArt = EmojiArt()
```
This is really just..
```swift
struct Published { 
	var wrappedValue 
}
```
- The type of this wrappedValue is the type of the var 
- Swift also makes theses types avaliable and they essentially are doing all the "magic": 
```swift
var _emojiArt: Published = Published(wrappedValue: EmojiArt())
var emojiArt: EmojiArt { 
	get { _emojiArt.wrappedValue}
	set { _emojiArt.wrappedValue = newValue }
}
```
- There is another var inside Property Wrapper structs that is accessed ups **$**
- Example: **$emojiArt**
- Its type is up to the Property Wrapper. In Published's it is **Publisher<EmojiArt, Never>**
## @Published 
- It publishes the change through its **projectedValue ($emojiArt)** which is a Publisher
- It invokes **objectWillChange.send()** in its enclosing **ObservableObject**
## @State
- wrappedValue is **any value type**
- What it does: **stores the wrapped Value in the heap; when it changes, invalidates the View **
- Projeted Value (i.e. $): a **Binding** (to th value in the heap)
- It's tricky to initai;lize a @State in yoour View's init ..
```swift
@State private var foo: Int 
init() { 
	_foo = .init(initialValue:5)
}
```
## @StateObject
- Like **@State** BUT for **ObservableObjects** (aka ViewModels) instead of for vcalue types
- Behaves like an **@ObservedObject** var, except..
- A @StateObject is a "source of truth"
- Always create it with an initial value 
- An **#ObservedObject** IS NOT a source of truth (it's a refernece for a source of truth)
- **You should never do @ObservedObject var foo = SomeObservableObject()**
- Can be used in a View or in an App or in an Scene
- If in a View -> **the lifetime of the ViewModel will be tied to that of the View**
	- In other words -> when the View goes off-screen, the @StateObject will get tossed
	- Sometimes you want this such as when **a FetchedImageView (we want to dump the image bits when View goes off screen)**
- Most time, it is NOT WHAT YOU WANT -> **Ex. Anytime you share a ViewModel with any other View THAT IS NOT YOUR CHILD **
## @StateObject and @ObservedObject
- WrappedValue is **anything that implements the ObservableObject protocol (viewModels)**
- What it does: **invalidates the View when wrappedValue does objectWillChange.send()**
- Projected value: **a Binding to the vars** of the wrappedValue ViewModel
	- The projected value Binding can be to any var expression, including subscripts
	- e.g. **$myViewModel.data.stuff[3]** is legal
## @Binding
- wrappedValue is **a value that is bound to something else**
- What is does -> **gets/sets the value of the wrappedValue from some other source**
- What it does -> **when the bound-to value changes, it validates the View**
- Projected value: **A Binding to the Binding itself**
### Where do we use Bindings??
- All over the place..
	- Getting text of a TextField
	- Using a Toggle or other state-modifying UI element
	- Finding out which item in a NavigatioNView was chosen
	- Finding out whether we're being targeted with a Drag
	- Binding our gesture to the .updating function of a gesture
	- Knowing about or causing a modally presented View's dismissal
- Bindings exist so we can have a **single source of truth**
## Binding to a Constant Value
- You can create a Binding to a constant value with **Binding.constant(value)**
## Computed Binding
- **Binding(get:, set:)** -> you can create your own bindings to arbitrary sources of data
## EnvironmentObject 
- Exactly the same as a **@ObservedObject**, but passed to a View in a different way..
```swift
let myView = MyView().environmentObject(theViewModel)

@EnvironmentObject var viewModel: ViewModelClass
```
- Environment objects are visible to all Views in your body (and thus to their body's Views) -> it is sometimes used when a number of Views are going to share the same ViewModel
- When presenting modally, you will want to use **@EnvironmentObject**
- Restriction -> **Can only use one @EnvironmentObject wrapper per ObservableObject type per View**
- WrappedValue -> **ObservableObject obtained via .environmentObject() sent to the View**
- What it does: **invalidates the View when wrappedValue does objectWillChange.send()**
- Projected Value -> **a Binding to the vars of the wrappedValue ViewModel**
## Environment (unrelated to @EnvironmentObject)
- Property Wrappers can have more variables than wrappedValue and projectedValue
- You can passvalues to set these other values using **( )** when you use the Property Wrapper
```swift
@Environment(\.colorScheme) var colorScheme
```
- In the above case, it specifies which instance variable to look at in an **EnvironmentValues** struct
- the wrappedValue's type is internal to the **Environment** Property Wrapper
- Its type will depend on which key path you're asking for
- wrappedValue -> **is the value of some var in EnvironmentValues**
- What it does -> gets a value of some var in EnvironmentValues
- Projected value -> **None**
# Demo Notes

