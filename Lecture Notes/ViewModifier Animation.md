# Animation
- You can animate a Shape (how our Pie is going to turn into a countdown timer)
-  You can also use ViewModifiers
# View Modifier
- Functions like aspectRatio and padding are call funtiosn called modifer
```swift
.modifier(AspectModifier(2/3))
```
The protocol has 1 function in it:
```swift
protocol ViewModifier {
	typealias Content // the type of the View passed to body(content:)
	func body(content: Content) -> some View {
		reutrn some View that almost certainly contains the View content
		}
	}
```
- You can call .modifier on a View, the Content passed to this functions is that View 
- There is also a special ViewModifer called GeometryEffect, for building gemetry modifiers

# Important takeaways about Animation
- Only changes can be animated. Only three kinds though:
1. ViewModifier arguments
2. Shapes
3. The "existence" (or not) of a View in the UI

- Animation is showing the user **changes that have already happend (i.e. the recent past).**
- ViewModifiers are the primary change agents in the UI
- A change to a ViewModifier's arguments **has to happen AFTER the View is initially pout in the UI**
- A View coming on-screen is only aniamted if it's joining a container that is already in the UI
- A View going off-screen is only animated if it's leaving a container that is staying in the UI
- **ForEach and if-else in ViewBuilders are common ways to make Views come and go**
# How to make animations "go"?
1. Implicity -> using a view modifier called .animation(Animation)
2. Explicity -> wrapping withAnimation(Animation) { } around code that might change things
3. By making Views be included or excluded from the UI
Note: **Again, all the above ONLY causes animation to "go" if the View is already part of the UI (or if the View is joining a container that is already partof the UI)**
# Implicit (automatic) Animation
- All ViewModifier arguments that PRECEDE the animation modifier will ALWAYS be animated
- the argument to .animation() is an Animation struct
- It lets you control things about the animation like: duration, delay, whether it should repeat, and its curve
## Animation Curve
- .linear = consistent rate throughout
- .easeInOut = starts out the animation slowly, picks up speed, and then slows down in the end
- .spring = provides "soft landing", a "bounce"
# Transitions
- Specific how to animate the arrival/departure of a View
- Only works for Views that are inside Containers That Are Already On-Screen (CTTAAOS)
- A transition is nothing more than a pair of ViewModifiers
- One of them is "before" modification and the other is the "after" modification
- All the transitions are "type erased".
- We use the struct AnyTransition which erases types info for the underlying ViewModifiers (this makes it a lot easier to work with transitions)
- .transition() is **just specifiying what the ViewModifiers are**
- It doesn't cause any animation to occur
# Setting Animation Details for a Transition
- You can set an animation to use a transition
- AnyTransition structs have a .animation(Animation) of their own you can call
- This sets the Animation parameters to use to animate the transition
- e.g. .transition(AnyTransition.opacity.animation(.linear(duration: 20)))
# .onAppear
- Animations only work on Views that are in CTAAOS
- .onAppear { } -> executes a closer any time a View appears on screen 
- Use .onAppear { } on your container view to cuase a chance (usually in Model/ViewModel) that results in the appearance/animation of the View you want to be animated
- We'll use .onAppear { } to kick off a couple of animations in demo this week.
# How do animations actually happen? 
- The animation system divides the animation's duration up into little pieces (along whatever "curve" the animation uses)
- A Shape or ViewModifier lets the animation system know what information it wants piece-fied. 
- During animation, the system tells the Shape/ViewModifier the current piece it should show. 