# Gestures
- Our job is to handle the gesture 
- We need to use the .gesture View Modifier to implement the Gesture protocol
- Create a func that craetes the actual Gesture
## Handling the Recognition of a Discrete Gesture
- It depends on whether the gesture is discrete or not 
- To do something when a discrete gesture is recognized, we use .onEnder { }/
```swift
var theGesture: some Gesture { 
	return TapGesture(count: 2)
		.onEnded { // Do something }
}
```
## Non-Discrete Gestures 
- You must handle that the gesture is recognized and also the gesture WHILE IT IS IN THE PROCESS OF HAPPENING (fingers are moving)
- Ex. **DragGesture, Magnification  Gesture, RotationGesture, LongPressGesture**
```swift
var theGesture: some Gesture { 
	return DragGesture(...)
		.onEnded { value in // Do something }
}
```
- What the value is varies from gesture to gesture
- During a non-discrete gesture, you'll also get a chance to do something while it's happening 
- Every time something changes, you will get a chance to update some state
- **This var will ALWAYS return to starting value when the gesture ends**
- Your only oportunity to change @GestureState var ...
```swift
var theGesture: some Gesture { 
	DragGesture(...) 
		.updating($myGestureState) { value, myGestureState, transaction in 
			myGestureState = /* usually something related to value */
			}
			.onEnder { value in /* do something /*/ }
	}
```
- This .updating will caus the closure you pass to it to be called when the fingers move 
- **Note the $ in front of your @GestureState var **
- 