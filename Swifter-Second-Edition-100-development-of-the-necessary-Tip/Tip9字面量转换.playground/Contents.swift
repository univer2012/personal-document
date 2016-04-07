//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

// “所谓字面量，就是指像特定的数字，字符串或者是布尔值这样，能够直截了当地指出自己的类型并为变量进行赋值的值。比如在下面:
let aNumber = 3
let aString = "Hello"
let aBool = true

//“中的 3，Hello 以及 true 就称为字面量。

//在 Swift 中，Array 和 Dictionary 在使用简单的描述赋值的时候，使用的也是字面量，比如：
let anArray = [1, 2, 3]
let aDictionary = ["key1":"value1", "key2":"value2"]

/*
 “Swift 为我们提供了一组非常有意思的接口，用来将字面量转换为特定的类型。对于那些实现了字面量转换接口的类型，在提供字面量赋值的时候，就可以简单地按照接口方法中定义的规则“无缝对应”地通过赋值的方式将值转换为对应类型。这些接口包括了各个原生的字面量，在实际开发中我们经常可能用到的有：
    ·  ArrayLiteralConvertible
    ·  BooleanLiteralConvertible
    ·  DictionaryLiteralConvertible
    ·  FloatLiteralConvertible
    ·  NilLiteralConvertible
    ·  IntegerLiteralConvertible
    ·  StringLiteralConvertible
 */
// 所有的字面量转换接口都定义了一个 typealias 和对应的 init 方法。拿 BooleanLiteralConvertible 举个例子：
#if true    //false
protocol BooleanLitearalConvertible {
    typealias BooleanLiteralType
    ///Create an instance initialized to 'value'
    init(booleanLiteral value: BooleanLiteralType)
}
#endif

//“在这个接口中，BooleanLiteralType 在 Swift 标准库中已经有定义了:
#if true    //false
///The default type for an otherwise-unconstrained boolean literal
typealias BooleanLiteralType = Bool
#endif

//“于是在我们需要自己实现一个字面量转换的时候，可以简单地只实现定义的 init 方法就行了。举个不太有实际意义的例子，比如我们想实现一个自己的 Bool 类型，可以这么做：
enum MyBool: Int {
    case myTrue, myFalse
}

extension MyBool : BooleanLitearalConvertible {
    init(booleanLiteral value: Bool) {
        self = value ? myTrue : myFalse
    }
}

//“这样我们就能很容易地直接使用 Bool 的 true 和 false 来对 MyBool 类型进行赋值了：
let myTrue = MyBool(booleanLiteral: true)
let myFalse = MyBool(booleanLiteral: false)

myTrue.rawValue
myFalse.rawValue

//“BooleanLiteralType 大概是最简单的形式，如果我们深入一点，就会发现像是 StringLiteralConvertible 这样的接口要复杂一些。这个接口不仅类似于上面布尔的情况，定义了 StringLiteralType 及接受其的初始化方法，这个接口本身还要求实现下面两个接口：
#if false
    ExtendedGraphemeClusterLiteralConvertible
    UnicodeScalarLiteralConvertible
#endif

// “这两个接口我们在日常项目中基本上不会使用，它们对应字符簇和字符的字面量转换。虽然复杂一些，但是形式上还是一致的，只不过在实现 StringLiteralConvertible 时我们需要将这三个 init 方法都进行实现。

//还是以例子来说明，比如我们有个 Person 类，里面有这个人的名字：
class Person {
    let name: String
    init(name value: String) {
        self.name = value
    }
}

// “如果想要通过 String 赋值来生成 Person 对象的话，可以改写这个类：

class Preson: StringLiteralConvertible {
    let name: String
    init(name value: String) {
        self.name = value
    }
    
    required init(stringLiteral value: String) {
        self.name = value
    }
    
    required init(extendedGraphemeClusterLiteral value: String) {
        self.name = value
    }
    
    required init(unicodeScalarLiteral value: String) {
        self.name = value
    }
}


// “在所有的接口定义的 init 前面我们都加上了 required 关键字，这是由[初始化方法的完备性]需求所决定的，这个类的子类都需要保证能够做类似的字面量转换，以确保类型安全。

//在上面的例子里有很多重复的对 self.name 赋值的代码，这是我们所不乐见的。一个改善的方式是在这些初始化方法中去调用原来的 init(name value: String)，这种情况下我们需要在这些初始化方法前加上 convenience：
class Person1: StringLiteralConvertible {
    let name: String
    init(name value: String) {
        self.name = value
    }
    
    required convenience init(stringLiteral value: String) {
        self.init(name: value)
    }
    required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(name: value)
    }
    required convenience init(unicodeScalarLiteral value: String) {
        self.init(name: value)
    }
    
    
}

let p: Person1 = "xiaoMing"
print(p.name)

//输出：
// xiaoMing

//“上面的 Person 的例子中，我们没有像 MyBool 中做的那样，使用一个 extension 的方式来扩展类使其可以用字面量赋值，这是因为在 extension 中，我们是不能定义 required 的初始化方法的。也就是说，我们无法为现有的非 final 的 class 添加字面量转换 (不过也许这在今后的 Swift 版本中能有所改善)。

//总结一下，字面量转换是一个很强大的特性，使用得当的话对缩短代码和清晰表意都很有帮助；但是这同时又是一个比较隐蔽的特性：因为你的代码并没有显式的赋值或者初始化，所以可能会给人造成迷惑：比如上面例子中为什么一个字符串能被赋值为 Person？你的同事在阅读代码的时候可能不得不去寻找这些负责字面量转换的代码进行查看 (而如果代码库很大的话，这不是一件容易的事情，因为你没有办法对字面量赋值进行 Cmd + 单击跳转)。

//“和其他 Swift 的新鲜特性一样，我们究竟如何使用字面量转换，它的最佳实践到底是什么，都还是在研究及讨论中的。因此在使用这样的新特性时，必须力求表意清晰，没有误解，代码才能经受得住历史考验。
















