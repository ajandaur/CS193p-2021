# Error Handling
## Throwing Errors
- A number of functions use a **throws** keyword -> means that they can "throw" an error at you when you call them
## You must try
- When you call a function that can throw, you must "**try**" it.
- Image a function that reads data from a url (and throws when there's an i/o error)...
```swift
func read(from: URL) throws
```
To call this, you must use the **try** keyword ..
```swift
try read(from: url)
```

### There are different ways to try depending on how you want to handle an error thrown at you..
1. Choosing not th handle an error thrown at you .. using **try?**
```swift
if let imagData = try? Data(contentsOf: url) { ... }
try? someFucntionThatCanThrowAndDoesntReturnSomething()
```
2. **try!** -> crashes program if an error is thrown
```swift
try! data.write(to: url)
```
3. **try** inside a function that it itself marked as throws (this rethrows any error that is thrown)
```swift
func foo() throws {
	try somethingThatThrows()
}
```
In this last scenario, any code that foo() must do so with try (e.g. **try foo()**).

## Actually handling a thrown error
- Must wrap the try with a **do { } catch** around your code that is going to try somrthing
```swift
do { 
	try functionThatThrows()
} catch let error {
	// handle the thrown error here 
}
```
The "let error" can be left off if you want.. 
Or you can change it to "let foo" in which case the error variable inside the catch will be foo. 
## Ways to catch 
- You can more specific about the kinds of errors you want to handle
- You can add catch phrases to your do { } catch { } ...
```swift
do { 
	try somethingThatThrows()
	print("hello") // will only happen if somethingThatThrows() does not throw anything
	} catch CS193pError.lateHomework(let daysLate) {
		// notice how daysLate is grabbing some error-specific enum associated data
	} catch let cs193p Error where cs193pError is CS193pError {
	// handle all CS193pErrors other than .lateHomework (which handled above)
	} catch {
	// hande all other
	}
	print("keep going") // will execute next after any caught error is handled
```
# Persistance 
## Storing Data Permanently 
1. In the filesystem (**FileManager**)
2. In a SQL database (**CoreData** for OOP access or direct SQL calls)
3. **CloudKit** (a database in the cloud)
4. Many third-part options as well
5. **UserDefaults** (only for lightweight data like user preferences)
## File System
- You can only read and write in your application's "sandbox"
### Why sandbox?
- Security (no else can damage app)
- Privacy (no other application can view your application's data)
- Cleanup (when you delete an application, everything it has written goes with it)
- Backup (certain parts of sandbox are backed up when device is backed up)
## What is in "sandbox"?
- Application directory -> your executable
- Documents directory -> permanent storage crated by and visible to user
- Application Support directory -> Permanent storage not seen directly by the user
- Caches directory -> Store temporary files (not backed up)
- And some other directories
## Getting path to these special sandbox directories
- **FileManager (along with URL)** is what is used to find out what's in file system
- Usually, we use the "default", shared FileManager (static):
```swift
FileManager.default
```
- You could use this to get a URL to one of the special directories mentioned above..
```swift
let manager = FileManager.default
let url = manager.urls(for .documentDirectory, in: .userDomainMask).first

# could also use .applicationSupportDirectory or .cachesDirectory, etc
```
## Building on top of these system paths
- URL methods: 
```swift 
func appendingPathCompent(String) -> URL
func appendingPathExtension(String) -> URL // e.g. "jpg"
```
- Finding out about what's at the other end of a URL
```swift
var isFileURL: Bool // is this a file URL or something else?
func resourceValues(for keys: [URLResourceKey]) throws -> [URLResourceKey: Any]?
```
Example keys: .creationDateKey, .isDirectoryKey, .fileSizeKey
## Data 
### Reading
- Reading binary data from a URL..
```swift
init(contentsOf: URL, options: Data.ReadingOptions) throws
```
The options are alsot always **[ ]**
Notice that this functiosn throws 

### Writing
Writing binary data to a URL
```swift
func write(to url: URL, options: Data.WriteOptions) throws -> Bool
```
The option can be things like .atomic (write to tmp file, then swap) or .withoutOverwriting
Notice that this function throws
## Codable Mechanism 
- Essentially a way to store all the vars of an object into a persistable blob
- It's a great way to make an arbitrary struct be persistable (into the file system or wherever)
- You must implement the Codable protocol
- **For structs which contain any other Codables, Swift will implement the Codable for you**
- **For enums, Swift will implement the Codable for you, unless you have associated data**
- Most standard types already implement Codable 
- Once your object graph is all Codable, you can convery it to JSON (a standard form)
```swift
let object: MyType = .. // myType must conform to Codable
let jsonData: Data? = try? JSONEncoder().encode(object)
```
Note that this encode throws. You can catch and find errors easily..
### Make JSON String out of your jsonData..
```swift
let jsonString = String(data: jsonData!, encoding: .utf8) // JSON is always utf8
```
### You could also just write your jsonData out to a file with a URL you got from FileManager..
```swift
if let myObject: myType = try? JSONDecoder().decode(MyType.self, from: jsonData!) {
	// do something with myObject, which we just decoded from jsonData
}
```
# Codable Example
- Sometimes JSON keys may have different names than your var names
- For example, **someDate might be some_date**
- You can configure this by adding a private enum to your type calling **CodingKeys**.. 
```swift
struct MyType: Codable { 
	var someDate: Date
	var someString: String
	var other: SomeOtherType // SomeOtherType has to be Codable too
	
	private enum CodingKeys: String, CodingKey {
		case someDate = "some_date"
		// note that the someString var will now not be included in the JSON
		case other // this key is also called "other" in JSON
	}
}
```
- What happens if we have an eum with **associated values**??
	- add **init(from decoder: Decoder)** to struct you want to decode
# UserDefaults
- is an "ancient" API
## Property Lists
- UserDefaults can only store waht is called a **Property List**
- This is not a protocol or a struct or anytinh tangible or swift-like
- Property List simply a "concept"
- It is any combination of **String, Int, Bool, Floating point, Date, Data, Array, or Dictionary**
## The Any type 
- lot of uses of the type Any (means "untyped")
- We're going to try and ignore it or User Defaults
## Using UserDefaults
```swift
let defaults - UserDefaults.standard
```
## Storing Data
```swift
defaults.set(object, forKey: "SomeKey") // objet must be a Property List
```
- There are convience methods that will check for types of values 
## Retrieving Data
```swift
let i: Int = defaults.integer(forKey: "MyInteger")
let b: Data = defaults.data(forKey: "MyData"
let u: URL = defaults.url(forKey: "myURL"
let strings: [String] = defaults.stringArray(forKey: "MyStrings")
```
# Demo Notes
- Persistance lives in the Model! 