//: [Previous](@previous)

/*:
 ## Some tips:
 */

/*:

 ### 减少 Any 和 AnyObject 类型的使用

 不要放弃编译检查

 如果无法避免，尽早把 Any 或者 AnyObject 转换成真正的类型，然后再使用
 */

/*:
 ### Obective-C 中暴露的接口，如果有容器类型，最好把微弱的泛型约束加上

 ```
 @property (nonatomic) NSArray<NSDate *> *dueDates;
 @property (nonatomic) NSDictionary<NSNumber *, NSString *> *dataDictionary;
 @property (nonatomic) NSSet<NSString *> *filter;

 ⬇️  ✅

 public var dueDates: [Date]
 public var dataDictionary: [NSNumber : String]
 public var filter: Set<String>
 ```


 ```
 @property (nonatomic) NSArray *dueDates;
 @property (nonatomic) NSDictionary *dataDictionary;
 @property (nonatomic) NSSet *filter;


 ⬇️ 🔴


 public var dueDates: [Any]
 public var dataDictionary: [AnyHashable : Any]
 public var filter: Set<AnyHashable>
 */



/*:

 ### Prefer Swift Value Types to Bridged Objective-C Reference Types

 You should almost never need to use a bridged reference type directly in your own code.
 */

/*
 | Swift value type        | Objective-C reference type |
 | ----------------------- | -------------------------- |
 | `AffineTransform`       | `NSAffineTransform`        |
 | `Array`                 | `NSArray`                  |
 | `Calendar`              | `NSCalendar`               |
 | `CharacterSet`          | `NSCharacterSet`           |
 | `Data`                  | `NSData`                   |
 | `DateComponents`        | `NSDateComponents`         |
 | `DateInterval`          | `NSDateInterval`           |
 | `Date`                  | `NSDate`                   |
 | `Decimal`               | `NSDecimalNumber`          |
 | `Dictionary`            | `NSDictionary`             |
 | `IndexPath`             | `NSIndexPath`              |
 | `IndexSet`              | `NSIndexSet`               |
 | `Locale`                | `NSLocale`                 |
 | `Measurement`           | `NSMeasurement`            |
 | `Notification`          | `NSNotification`           |
 | Swift numeric types     | `NSNumber`                 |
 | `PersonNameComponents`  | `NSPersonNameComponents`   |
 | `Set`                   | `NSSet`                    |
 | `String`                | `NSString`                 |
 | `TimeZone`              | `NSTimeZone`               |
 | `URL`                   | `NSURL`                    |
 | `URLComponents`         | `NSURLComponents`          |
 | `URLQueryItem`          | `NSURLQueryItem`           |
 | `URLRequest`            | `NSURLRequest`             |
 | `UUID`                  | `NSUUID`                   |
 */

/*:
 ### Write More Swift 🐤
*/

//: [Next](@next)
