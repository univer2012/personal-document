//: [Previous](@previous)

import Foundation
import UIKit


class Calcuator {
    var a: Int = 1
    private var b: Int = 1

    var sum: Int {
        get {
            return a + b
        }
        set {
            b = newValue - a
        }
    }
}
extension Calcuator {
    //计算型属性
    ///1、extension可以添加计算型属性。
    ///2、Swift 4及以上版本中，可以访问private属性。
    var multiplication: Int {
        get {
            return a * b
        }
        set {
            b = newValue / a
        }
    }
    
    //计算型静态属性
    static var div: Int {
        return 8 / 2
    }
    //计算型属性
    var subtraction: Int {
        return 4
    }
    
    //存储型属性
    ///报错：Extensions must not contain stored properties
    //var c:Int = 1
    
    //新的构造器
    convenience init(a:Int, b: Int) {
        self.init()
        self.a = a
        self.b = b
    }
    
}


//: [Next](@next)
