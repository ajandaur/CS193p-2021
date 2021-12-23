## View are not as "elegant" in UIKit 
- No MVVM either, MVC instead 
- MVC -> views are grouped together and controlled by a Controller
- This Controller is the granularity at which you present views on screen
## Integration
- There are two points of integration
	- **UIViewRepresntable** and a **UIViewControllerRepresentable**
	- They each turn a UIKit view or controller into a SwiftUI View
	- They are extremely similar 
	- The main work involved is interfacing with the given view or controller's API