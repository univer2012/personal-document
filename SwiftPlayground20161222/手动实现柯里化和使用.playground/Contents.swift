import UIKit



func add(_ a: Int) -> (Int) -> (Int) -> Int{
    return { b in
        return { c in
            a + b + c
        }
    }
}
// 使用
let one = add(1)(2)(3)//add(1)
//let result = one(2)(3)
print(one)
