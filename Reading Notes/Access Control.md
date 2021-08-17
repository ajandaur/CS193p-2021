_Access control_ restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.

You can assign specific access levels to individual types (classes, structures, and enumerations), as well as to properties, methods, initializers, and subscripts belonging to those types. Protocols can be restricted to a certain context, as can global constants, variables, and functions.

In addition to offering various levels of access control, Swift reduces the need to specify explicit access control levels by providing default access levels for typical scenarios. Indeed, if you are writing a single-target app, you may not need to specify explicit access control levels at all.
# Access Levels
Swift provides five different _access levels_ for entities within your code. These access levels are relative to the source file in which an entity is defined, and also relative to the module that source file belongs to.

-   _Open access_ and _public access_ enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework. The difference between open and public access is described below.
-   _Internal access_ enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app’s or a framework’s internal structure.
-   _File-private access_ restricts the use of an entity to its own defining source file. Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.
-   _Private access_ restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file. Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration.
## Guiding Priciple of Access Levels
Access levels in Swift follow an overall guiding principle: _No entity can be defined in terms of another entity that has a lower (more restrictive) access level._

For example:

-   A public variable can’t be defined as having an internal, file-private, or private type, because the type might not be available everywhere that the public variable is used.
-   A function can’t have a higher access level than its parameter types and return type, because the function could be used in situations where its constituent types are unavailable to the surrounding code.

The specific implications of this guiding principle for different aspects of the language are covered in detail below.
## Default Access Levels
All entities in your code (with a few specific exceptions, as described later in this chapter) have a default access level of internal if you don’t specify an explicit access level yourself.** As a result, in many cases you don’t need to specify an explicit access level in your code.**
## Access Levels for Single-Target Apps
When you write a simple single-target app, the code in your app is typically self-contained within the app and doesn’t need to be made available outside of the app’s module. The default access level of internal already matches this requirement. Therefore, you don’t need to specify a custom access level. You may, however, want to mark some parts of your code as **file private or private in order to hide their implementation details from other code within the app’s module.**
## Access Levels for Frameworks
When you develop a framework, mark the public-facing interface to that framework as **open or public **so that it can be viewed and accessed by other modules, such as an app that imports the framework. This public-facing interface is the application programming interface (or API) for the framework.
## Access Levels for Unit Test Targets
When you write an app with a unit test target, the code in your app needs to be made available to that module in order to be tested. By default, only entities marked as open or public are accessible to other modules. **However, a unit test target can access any internal entity, if you mark the import declaration for a product module with the `@testable` attribute and compile that product module with testing enabled.**
# Access Control Syntax
Define the access level for an entity by placing one of the `open`, `public`, `internal`, `fileprivate`, or `private` modifiers at the beginning of the entity’s declaration.
```swift
public class somePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0 
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
```
