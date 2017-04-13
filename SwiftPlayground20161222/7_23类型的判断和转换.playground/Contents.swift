//: Playground - noun: a place where people can play

import UIKit

//swift提供了2个用于处理对象之间关系的操作符，它们是 is 、as。对于as 来说， 根据不同的应用情况，又有3个不同的形态，包括 `as`、`as?`、`as!`，应该如何使用这些操作符，通过下面来认识它们。
//: #### is as as? as!

//class Shape {}
protocol Shape {}                                   //***2
class Rectangle: Shape {}
class Circle: Shape {}

let r = Rectangle()
let c = Circle()
//let shapeArray = [r, c]
//let shapeArray: Array<AnyObject> = [r, c]         //(***1)
let shapeArray: Array<Shape> = [r, c]               //***2
type(of:shapeArray)
//如果要统计shapeArray中各种形状的数量，就可以使用`is`操作符。
//定义2个用于计数的变量：
var totalRects: Int = 0
var totalCircles: Int = 0
for s in shapeArray {
    if s is Rectangle {
        totalRects += 1
    }
    else if s is Circle {
        totalCircles += 1
    }
}
totalRects
totalCircles
//这就是`is`操作符的用法，它用`a is b`来判断某个对象的类型。

//除了判断对象类型之外，还可以对类型进行转换。
//在一个继承关系里，通常派生类到基类的类型转换是自动完成的，因为本身就符合派生类是某种类型的基类这样的语义。但是从基类到派生类的转换通常需要我们明确指定的。我们管这样的类型转换叫做 `downcasting`，在swift里，我们使用`as`关键字来完成这个操作。
//根据不同的应用场景，`as`有2个不同的版本，分别是`as?`、`as!`。
//在类型转换时，`as?`会返回一个目标类型的Optional，而`as!`在转换失败时会引发一个运行时错误。我们看一个例子：
type(of: (shapeArray[0] as? Rectangle))
type(of: (shapeArray[0] as! Rectangle))
//type(of: (r as! Double))
//从转换结果可以看到，当我们使用`as?`进行类型转换时，会直接返回一个目标类型的Optional
//而当我们使用`as!`进行转换并且成功时，会直接返回目标类型；而当`as!`类型转换失败时，会直接引发一个运行时错误。
//因此，我们只有确认`downcasting`一定会成功时，使用`as!`才是类型安全的。


//除了用于`downcasting`之外，`as!`还可以用于 `AnyObject`这种类型的转换。
//在swift里，我们使用`AnyObject`表示任意一种类型的对象。
//例如，可以让之前的shapeArray变成`AnyObject`：(***1)
//这时可以看到之前的转换结果仍然是成功的。




//直接使用 `as`自身
//在swift里，使用`Any`表示任意一种类型。
let box: Array<Any> = [
    3,
    3.14,
    "3.14",
    r,
    { return "I'm a closure" }
]
//通过一个`switch case`根据数组中的每一个类型，进行不同的操作。
for item in box {
    switch item {
    case is Int:
        print("\(item) is Int")
    case is Double:
        print("\(item) is Double")
    case is String:
        print("\(item) is String")
        //可以在case的value-binding里面使用`as`。
        //在这里无需使用`as?`或者`as!`，当item的类型是Rectangle时，它就会自动地把值绑定到rect上。
    case let rect as Rectangle:
        print("\(item) is Rectangle")
        //接下来对函数类型做类似的转换。
    case let fn as ()->String:
        fn()
    default:
        print("Out of box")
    }
}
//通过这个例子可以看到，`is`不仅可以判断类型关系，也可以用于判断`Any`或者其他类型的关系。
//而`as`可以直接用在`switch case`里，它可以直接把对象转换为目标类型。




//除了转换`Any`和`AnyObject`之外，`is`和`as`还可以用于判断某个类型是否遵从protocol的约定。
//例如，作为一个抽象的概念，Shape可能更适合作为一个protocol：(***2)
box[0] is Shape     //表示我们希望判断box[0]是否遵从了Shape的约定


//同样，也可以用`as`操作符把对象转换为一个protocol类型：
type(of: box[3] as? Shape)
type(of: box[3] as! Shape)
//type(of: box[2] as! Shape)
//在这里，有一个小细节需要注意，当类型转换成功时，如果使用的是`as!`，swift会把转换结果变成对象的真实类型，而不是protocol类型。
//而当我们`as?`进行转换时，得到的就会是一个目标类型的Optional




