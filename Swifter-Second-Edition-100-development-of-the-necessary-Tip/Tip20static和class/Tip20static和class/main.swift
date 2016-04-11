//
//  main.swift
//  Tip20static和class
//
//  Created by huangaengoln on 16/4/10.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")
/*
 “Swift 中表示 “类型范围作用域” 这一概念有两个不同的关键字，它们分别是 static 和 class。这两个关键字确实都表达了这个意思，但是在其他一些语言，包括 Objective-C 中，我们并不会特别地区分类变量/类方法和静态变量/静态函数。但是在 Swift 的早期版本中中，这两个关键字却是不能用混的。
 
 “在非 class 的类型上下文中，我们统一使用 static 来描述类型作用域。这包括在 enum 和 struct 中表述类型方法和类型属性时。在这两个值类型中，我们可以在类型范围内声明并使用存储属性，计算属性和方法。static 适用的场景有这些：
 */
struct Point {
    let x: Double
    let y: Double
    
    //存储属性
    static let zero = Point(x: 0, y: 0)
    
    //计算属性
    static var ones: [Point] {
        return [Point(x: 1, y: 1),
                Point(x: -1, y: 1),
                Point(x: 1, y: -1),
                Point(x: -1, y: -1)]
    }
    
    //类型方法
    static func add(p1: Point, p2: Point) ->Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}
//“enum 的情况与这个十分类似，就不再列举了。




//“class 关键字相比起来就明白许多，是专门用在 class 类型的上下文中的，可以用来修饰类方法以及类的计算属性。但是有一个例外，class 中现在是不能出现 class 的存储属性的，我们如果写类似这样的代码的话：
class Bar {
    
}
#if false
class MyClass {
    class var bar: Bar?
}
#endif
//“编译时会得到一个错误：
//Class stored properties not yet supported in classes; did you mean 'static'?

//“在 Swift 1.2 及之后，我们可以在 class 中使用 static 来声明一个类作用域的变量。也即：
class Myclass1 {
    static var bar: Bar?
}

//“有一个比较特殊的是 protocol。在 Swift 中 class，struct 和 enum 都是可以实现某个 protocol 的。那么如果我们想在 protocol 里定义一个类型域上的方法或者计算属性的话，应该用哪个关键字呢？答案是使用 static 进行定义。在使用的时候，struct 或 enum 中仍然使用 static，而在 class 里我们既可以使用 class 关键字，也可以用 static，它们的结果是相同的：
protocol MyProtocol {
    static func foo() ->String
}
struct MyStruct: MyProtocol {
    static func foo() -> String {
        return "MyStruct"
    }
}
enum MyEnum: MyProtocol {
    static func foo() -> String {
        return "MyEnum"
    }
}

class MyClass2: MyProtocol {
    //在class中可以使用class
    class func foo() -> String {
        return "MyClass2.foo()"
    }
    
    //也可以使用static
    static func bar() ->String {
        return "MyClass2.bar()"
    }
}

//“在 Swift 1.2 之前 protocol 中使用的是 class 作为关键字，但这确实是不合逻辑的。Swift 1.2 和 2.0 分两次对此进行了改进。现在只需要记住结论，在任何时候使用 static 应该都是没有问题的。














