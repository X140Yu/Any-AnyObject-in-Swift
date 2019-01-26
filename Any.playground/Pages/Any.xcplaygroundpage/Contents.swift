//: [Previous](@previous)


/*:
 # Any

 ```
 let a: Any = "str"
 ```
 */

/*:
 ## 什么是 Any? 🤔

 `Any` can represent an **instance** of any type at all, including function types. [doc](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html)

 `Any` 可以代表一个任意类型的实例，包括函数类型。

 */

var any: Any = "Any"

// static type is `Any`, dynamic type is `Int`
any = 42
type(of: any)

// static type is `Any`, dynamic type is `String`
any = "string"
// static type is `Any`, dynamic type is `(Int, String)`
any = (42, "42")
// static type is `Any`, dynamic type is `[Int]`
any = [1, 2, 3]
// static type is `Any`, dynamic type is `[Int: Int]`
any = [1: 2]


/*:
 ### Closures can be `Any`
 */
any = {}
// ... actually is
let c: () -> () = {}

/*:
 Functions are just named closures, so it can be `Any`
 */
func function() {}
any = function
// ... actually is
let f: () -> () = function
let fs: () -> () = function.self
// 上面用 `self` 和不用 `self` 有什么区别呢？🤔

1
1.self

/*:
 ### Enums can be `Any`
 */

/*:
 💡 Optionals are enums
 */
any = Optional<Int>(1) as Any
// ... actually is
let o: Optional<Int> = Optional<Int>(1)
// or
let o1: Int? = Optional<Int>(1)

any = Optional<Int>.self
// ... actually is
let o2: Optional<Int>.Type = Optional<Int>.self
// or
let o3: Int?.Type = Optional<Int>.self


/*:
 ### Structs and classes can be `Any`
 */

/*:
 💡 String is a struct
 */
any = "abc"
any = String.self
// ... actually is
let s: String.Type = String.self

/*:
 💡 KeyPath is a class
 */
any = \String.count as Any

any = KeyPath<String, Int>.self


let k2: KeyPath<String, Int>.Type = KeyPath<String, Int>.self
// ... can be
let k1: AnyObject.Type = KeyPath<String, Int>.self
// or
let k: AnyClass = KeyPath<String, Int>.self

/*:
 Protocols can be `Any`
 */

/*:
 💡 Error is a protocol
 */
any = Error.self
// protocol is not like other types (sturct, class ...)
// so this is not correct
//let e1: Error.Type = Error.self
// ... actually is
let e: Error.Protocol = Error.self

// this is correct
struct TestError: Error {}
let e2: Error.Type = TestError.self

/*:
`Any` means anything

 所以它也能代表它自己 😎
*/

any = Any.self
// ... actually is
let ap: Any.Protocol = Any.self

/*:
无奖竞猜，`Never` 和 `Void` 分别是什么类型？ 🤔
 */

any = Never.self
any = Void.self
any = ().self
any = AnyObject.self


/*:
 上面介绍了从任意类型转换成 `Any`

 那么如何把 `Any` 转换成想要的类型呢？(Downcast)
 */

let thing: Any = 42

// if let

if let integer = thing as? Int {
    integer
}

// ... or simpler

thing as! Int

// or use `switch`

let things: [Any] = [
    0,
    0.0,
    "hello",
    42,
    (0, 0),
    Optional<Int>.self,
    { (name: String) -> String in "Hello, \(name)" }
]

for thing in things {
    switch thing {
    case 0 as Int:
        "zero as an Int"
    case 0 as Double:
        "zero as a Double"
    case let someInt as Int:
        "an integer value of \(someInt)"
    case let someDouble as Double where someDouble > 0:
        "a positive double value of \(someDouble)"
    case is Double:
        "some other double value that I don't want to print"
    case is Optional<Int>.Type:
        "type optional int.self"
    case let someString as String:
        "a string value of \"\(someString)\""
    case let (x, y) as (Double, Double):
        "an (x, y) point at \(x), \(y)"
    case let stringConverter as (String) -> String:
        stringConverter("Michael")
    default:
        "something else"
    }
}

//: [Next](@next)
