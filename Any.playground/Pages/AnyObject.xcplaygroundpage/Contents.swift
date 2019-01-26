//: [Previous](@previous)

/*:
 # AnyObject

 */

/*:
 ## What is `AnyObject`?

 `AnyObject` can represent an instance of any class type. [doc](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html)

 The protocol to which all classes implicitly conform.

 ```
 let v: AnyObject = AnyClassInstance
 ```
 */

// 一起来看一下 AnyObject 的源码

import Cocoa
var any: AnyObject.Protocol = AnyObject.self
let any1: AnyObject = NSObject()
let any2: AnyObject.Type = NSObject.self

/*:
 比较早使用过 Swift 的同学对 AnyObject 一定不会陌生

 因为在 Swift 3 之前，`AnyObject` 是作为 Objective-C `id` 的存在
 ```
swift(<3.0)
 id label = [UILabel new];
 // equals
 var label: AnyObject = UILabel()
 ```

 但是随着 swift-evolution 的这个 proposal [SE-0116](https://github.com/apple/swift-evolution/blob/master/proposals/0116-id-as-any.md)

 在 Swift 3 中，Objective-C 的 `id` 被 map 到了 `Any`

 ```
swift(>=3.0)
 id label = [UILabel new];
 // equals
 var label: Any = UILabel()
 ```
 */

/*:
 这么做的目的是什么？🤔
 */

struct 🐱 {
    let name: String
}

extension Notification.Name {
    static let CatDidMeow = Notification.Name(rawValue: "cat.did.meow")
}

/*:

```
swift(<3.0)
NotificationCenter.default
    .post(
        name: .CatDidMeow,
        object: AnyObject?
        userInfo: [NSObject : AnyObject]?)

 final class Box<T>: NSObject {
    let value: T
    init(_ value: T) {
        self.value = value
    }
 }

 // post
 NotificationCenter.default
    .post(
    name: .CatDidMeow,
    object: nil
    userInfo: ["cat" : Box(🐱(name: "Kitty"))])

 // observe
 if let box = notification.userInfo?["cat"] as? Box<🐱> {
    let cat = box.value
 }
```
 */

// swift(>=3.0)

NotificationCenter.default
    .addObserver(forName: .CatDidMeow,
                 object: nil,
                 queue: nil) { notification in
                    if let cat = notification.userInfo?["cat"] as? 🐱 {
                        cat.name
                    }
}

NotificationCenter.default
    .post(name: .CatDidMeow,
          object: nil,
          userInfo: ["cat": 🐱(name: "Kitty")])

/*:
✅ 目的是为了让 Swift 能够最大力度的使用已有 Cocoa 中的 Objective-C API

  💫 Use more value types
 */

/*:
 是如何实现的呢？🤔
 */

/*:
 ## When a Swift value or object is passed into Objective-C as an `id` parameter, the compiler introduces a universal bridging conversion operation.
 */


/*:
 ### @objc Classes
 */

/*:
 ### Bridged value types
 */

let date: NSDate = Date() as NSDate
let data: NSData = Data() as NSData

/*:
 ### Unbridged value types
 */

struct Person {
    let username: String
}

/*:
```
@interface Object : NSObject
- (void)updateUser:(id)user;
@end

// ... generated swift interface
func updateUser(user: Any)


let object = Object()
object.updateUser(Person(username: "abe"))
```

`Person` -> `_Swift_Value *`
 */


/*:
When `id` values are brought into Swift as `Any`, we use the runtime's existing ambivalent dynamic casting support to handle bridging back to either class references or Swift value types.

 ```
 @objcMembers
 public class SwiftClass: NSObject {
    public class func testID(_ any: Any) {}
 }

 [SwiftClass testID:someIDVariable]

 // ... equals

 let object = Object()
 let a = object as Any

 ```
*/

/*:
Quiz 📝
 */

let arrayOfAnyObject: [AnyObject] = [
    1 as AnyObject,
    "str" as AnyObject
]

arrayOfAnyObject.forEach { element in
    print(type(of: element))
    if let e = element as? Int { "Int \(e)" }
    if let e = element as? String { "String \(e)" }
    if let e = element as? NSString { "NSString \(e)" }
    if let e = element as? NSNumber { "NSNumber \(e)" }
}

let arrayOfAny = arrayOfAnyObject as [Any]

arrayOfAny.forEach { element in
    print(type(of: element))
    if let e = element as? Int { "Int \(e)" }
    if let e = element as? String { "String \(e)" }
    if let e = element as? NSString { "NSString \(e)" }
    if let e = element as? NSNumber { "NSNumber \(e)" }
}

let arrayOfAny2: [Any] = [1, "2"]
arrayOfAny2.forEach { element in
    print(type(of: element))
    if let e = element as? Int { "Int \(e)" }
    if let e = element as? String { "String \(e)" }
    if let e = element as? NSString { "NSString \(e)" }
    if let e = element as? NSNumber { "NSNumber \(e)" }
}

//: [Next](@next)
