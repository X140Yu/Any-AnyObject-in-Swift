//: [Previous](@previous)

/*:
 ## AnyObject 的其它作用

 ### `Weak`
 */

protocol SomeDelegate: AnyObject {}

// 🔴 error: 'weak' must not be applied to non-class-bound 'Any'; consider adding a protocol conformance that has a class bound
// weak var d: Any? = nil

import Cocoa

class SomeClass: NSObject {}
extension SomeClass: SomeDelegate {}

var someClassInstance: SomeClass? = SomeClass()

weak var d: AnyObject? = someClassInstance

someClassInstance = nil

d

//: [Next](@next)
