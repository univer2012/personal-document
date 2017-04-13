//: Playground - noun: a place where people can play

import UIKit

//除了对象属性外，有些属性是属于一个类型的，它们不和具体的对象相关，在Swift里，这些属性叫做`type property`。它们和C++中的类静态成员是类似的，和`stored property`不同，struct、class和enum都可以定义自己的`type property`
//: #### Type property
struct Point {
    var x = 100.0
    var y = 100.0
}
enum Shape {
    case RECT
    case TRIANGLE
    case CIRCLE
}

struct MyRect {
    static let shape = Shape.RECT
    var origin: Point
    var width: Double
    var height: Double
}
//由于这个属性对MyRect的所有对象都是一样的，它们都是Shape.RECT,因此我们就可以为MyRect添加一个`type property`。
//使用static 关键字来为自定义类型添加`type property`。
//定义好`type property`后，我们不能使用一个对象来访问它，而是要使用自定义类型的名字来访问它：
let shape = MyRect.shape
//帮助我们一个类型所有公共属性







