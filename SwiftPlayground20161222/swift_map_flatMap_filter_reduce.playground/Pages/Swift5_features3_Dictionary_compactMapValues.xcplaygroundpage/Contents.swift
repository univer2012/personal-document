//: [Previous](@previous)

import UIKit

let d:[String: String?] = ["a": "1", "b": nil, "c": "3"]
let r4 = d.compactMapValues({$0})
print(r4)
///打印：
///["c": "3", "a": "1"]

let ages = [
    "Mary": "42",
    "Bob": "twenty-five har har har!!",
    "Alice": "39",
    "John": "22"]

let filteredAges = ages.compactMapValues({ Int($0) })
print(filteredAges)
///打印：
///["John": 22, "Mary": 42, "Alice": 39]



extension Dictionary {
    public func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> [Key: T] {
        return try self.reduce(into: [Key: T](), { (result, x) in
            if let value = try transform(x.value) {
                result[x.key] = value
            }
        })
    }
}


//: [Next](@next)
