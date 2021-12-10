# App Architecture 
## Scene Protocol 
- A scene is a container for a top-level View that we want ot show in the UI 
- We can create our own Scene which has its own var body
	- This is rare.. 
	- The vast majority of the time, we can use SwiftUI's built-in Scene
- These three main types of Scene are..
	- **WindowGroup { return aTopLevelView }**
	- **DocumentGround(newDocument: )**
	- **DocumentGroup(viewing: )**
- These are a little bit like a ForEach for Scenes -> in that, each is created by "new window" or splitting the screen (on iPad)
- These Scenes have a **content** argument which is a function that returns some View 
- The return value of the content function is the top-level View of a new Scene 
- The **content** function is called each time a new window or screen-splitting is done by a user 
## WindowGroup
- Is the basic, non-document-oriented Scene-building Scene..
## SceneStorage 
- @SceneStorage property wrapper stores info persistently on a per-Scene bassi -> means they'll stick around even if the application is killed or otherwuise quits
- On Mac it's per window, on Ipad, as part of the screen if split 
- Changes to the @SceneStorage invalidate the View (like @State would)
## AppStorage
- @AppStorage property wrapper stores info persistently on an application-wide bassis
- This is essentially storing the values in UserDefaults 
- Also very restricted in what it can store (like @SceneStorage)
- Changes to @AppStorage invalidate the View (like @State and @SceneStorage)
## DocumentGroup
- **DocumentGroup** is the docunent-oriented Scene-building Scene 
- Here's what it looks like for an editable document (versus a document we can only view)
- Note that here we are definitely not using an @StateObject for our ViewModel
- The **config** argument contains the ViewModel to use (and the fileURL to the docunment too).
- In EmojiArt, **config.document** will be something of type EmojiArtDocument 
	```swift
		struct EmojiArtApp: App { 
			var body: some Scene { 
				DocumentGroup(newDocumnet: { EmojiArtDocument() }) { config in 
				EmojiArtDocumentView(document: config.document)
			}
		}
	}
	```
## DocumentGroup
- this version using DocumentGroup is for a **read-only document**
## FileDocument 
-  This protocol gets/puts the contents of a document from/to a file 
## ReferenceFileDocument 
- Almost identical to **FileDocument**.
- It inhierts ObservableObject. Soo it is ViewModel only.
- Theo only difference is that writing is done on a background thread via a **"snapshot"**
- The **Snapshot** type is "don't care", but usually it's a Data 
- **UIType** is a Uniform Type Identifier. We'll talk about this soon
## UTType (Uniform Type Identifier)
- Obviously there needs ot be a way to clearly express what type of file you can open/edit 
- This is done with Uniform Type Identifiers  