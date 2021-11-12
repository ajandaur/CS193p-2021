# Publishers
## What is a Publisher?
- It is an object that emits values and possibly a failure object if it fails while doing so.
```swift
Publisher<Output, Failure>
```
- Output = type of the thing this **Publisher** publishes
- Failure is the type of the thing it comunicates if it fails while trying to pubsh
- Output or Failure are "don't cares" (though Failure must implement **Error**)
- If the Publisher is not capable of reporting errors, the Failure can be **Never**
## What can we do with a Publisher?
- Listen to it! (subscrite to get its value and found out when its finishes publishing and why)
- Transform its value on the fly 
- shuttle its value off to somewhere else
- and much more!
## How do we listen or subscribe to a Publisher?
- You can simply execute a closure whenever a Publisher publishes..
```swift
cancellable = myPublisher.sink(
	recieveCompletion: { result in ... },
	recieveValue { thingThatPublisherPublishes in . . . }
)
```
- If the Publisher's Failure is **Never**, then you can leave out the recieve Completion above.
- Note that **.sink** returns something
- The returne thing implements the **Cancellable** protocol
- Very often we will type-erase this to **AnyCancellable** (just like with AnyTransition).
- What is its purpose?
	- You can send **.cancel()** to it to stop listening to that publisher
	- it keeps the **.sink** subscriber alive
- **Always keep this var somewhere that will stick around as long as yoou want the .sink to!**
### A View can also listen to a Publisher! 
```swift
	.onRecieve(publisher) { thingThePublisherPublishes in 
	// Do whatever you want with thingThePublisherPublishes
	}
```
- **.onRecieve** will automatically invalidate your View (causing a redraw)
# More Persistence
## Cloud Kit
- Storing data into a databse inthe cloud (on the network)
- This data will appear on all the user's devices 
## Core Data 
- Makes a SQL databse look "object-oriented"
- makes "ViewModels" for each of the entities in a SQL database
## Important Concepts in CloudKit 
- Record Type -> analogous to a class or struct
- Fields -> analogous to vars in a class or struct
- Record -> an "instance" of a Record Type 
- Reference -> a "pointer" to another Record
- Database -> a aplce where Records are stored 
- Zone -> a sub-area of a Database 
- Container -> collection of Databases
- Query -> a Database search
- Subscription -> a "standing Query" which sends push notifications when changes occur
## Dynamic Schema Creation
- If you start using a record type, Cloud Kit will automtically create it
## How to create a record in a database 
```swift
let db = CKContainer.default.public/shared/privateCloudDatabase
let tweet = CKRecord("Tweet")
tweet["text"] = "140 character of pure joy"
let tweeter = CKRecord("TwitterUser")
tweet["tweeter"] = CKReference(record: tweeter, action: .deleteSelf)
db.save(tweet) { (savedRecord: CKRecord?, error: NSError?) -> Void in 
	if error == nil { 
		// hooray!
		} else if error?.errorCode == CKErrorCode.NotAuthenicated.rawValue {
			// tell user he or she has to be logged in to iCloud for this week
		} else { 
			// report other errors (there are 29 different CKErrorCodes!)
		}
	}
```
## What it looks like to query for records in a database 
```swift
let predicate = NSPredicate(format: "text contains %@", searchString)
let query = CKQuery(recordType: "Tweet", predicate: predicate)
db.perform(query) { (records: [CKRecord]?, error: NSError?) in 
	if error == nil {
		// records will be an array of matching CKRecords
	} else if error?.errorCode == CKErrorCode.NotAutheticated.rawValue { 
		// tell user he or she has to be logged in to iCloud for this to work!
	} else { 
		// report other errors (there are 29 different CKErrorCodes!)
		}
	}
```
## Object Oriented Database 
- We switched to simple OOP with Core Data
## SQL vs. OOP
- programming SQL is very DIFFERENT than what we're doing in Swift 
- Core Data gives the best of both worlds -> it does the actual storing using SQL
- It all plugs beautifully into SwiftUI
## Map
- The heart of Core Data is creating a map 
- It is a map between the objects/vars we want and "tables and rows" of a relational databse 
- Xcode has a graphical editor for the map -> lets us graphically create "relationships" (vars that point to other objects)
## Then what?
- Xcode generates classes behind the scenes for the objects/vars we specified in the map
- We can use extensions to add our own methods and computed vars to those classes
## Features of Core Data 
- Creating objects
- Changing the values of their vars
- Saving the objects
- Fetching objects based on specific criteria
- Lots of other features like optimistic locking and undo management
## SwiftUI Integration
- objects we create in the databse are **ObservableObjects**
- Powerful property wrapper called **@FetchRequest** which fetches objects for us
- FetchRequest essentially represents a "standing query" taht is constantly being fulfilled -> keeps our UI always in sync
## The Setup for CoreData
- Start by clicking "Core Data" button when you create a project -> Create a blank "map" for you to your project 
- Access your database via **@Environment(\.managedObjectContext)** in your SwiftUI Views 
### The Map
![[Screen Shot 2021-11-10 at 9.06.17 PM.png]]
## The Code 
- You fin dthings in the database using **NSFetchRequest**
```swift
let request = NSFetchRequest<Flight?(entityName: "Flight")
```
- The "predicate" describing what you want is a format string
```swift
request.predicate = NSPredicate(format: "arrival < %@ and origin = %@", Date(), ksjc)
```
- And you specify the order you want the results returned to you as well ..
```swift
request.sortDescriptors = [NSSortDescriptor(key: "ident", ascending: true)]
```
- Then you fetch all the objects that match your request ...
```swift
let flights = try? context.fetch(request) // KSJC flights in the past sorted by ident
// flights is nil if fetched failed, [] if no such flights, otherwise [Flight]
```
## In SwiftUI..
- These Flights and Airports are **ViewModels**!!
