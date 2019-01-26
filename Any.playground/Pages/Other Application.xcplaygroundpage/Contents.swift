
//: [Previous](@previous)

/*:
 `Any` 和 `AnyObject` 还有哪些其它应用吗？
 */

/*:
 [Then](https://github.com/devxoul/Then) ✨

 */

import Foundation
import CoreGraphics

public protocol Then {}

extension Then where Self: Any {

    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///     let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    /// Makes it available to execute something with closures.
    ///
    ///     UserDefaults.standard.do {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
    public func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }

}

extension Then where Self: AnyObject {
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .Center
    ///       $0.textColor = UIColor.blackColor()
    ///       $0.text = "Hello, World!"
    ///     }
    public func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }

}

extension NSObject: Then {}

extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}


/*:
 You will get a super sweet syntactic sugar ✨
 */

import Cocoa

let frame = CGRect().with {
    $0.origin.x = 10
    $0.size.width = 100
}

_ = NSTextField().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 15)
}

// or your custom types

class 🐤 {
    var name: String = "bird"
}

extension 🐤: Then {}

let 🕊 = 🐤().with {
    $0.name = "dove"
}

🕊.name
//: [Next](@next)
