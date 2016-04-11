//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//“typealias 是用来为已经存在的类型重新定义名字的，通过命名，可以使代码变得更加清晰。使用的语法也很简单，使用 typealias 关键字像使用普通的赋值语句一样，可以将某个已经存在的类型赋值为新的名字。比如在计算二维平面上的距离和位置的时候，我们一般使用 Double 来表示距离，用 CGPoint 来表示位置：
func distanceBetweenPoint(point: CGPoint, toPoint: CGPoint) ->Double {
    let dx = Double(toPoint.x - point.x)
    let dy = Double(toPoint.y - point.y)
    return sqrt(dx * dx + dy * dy)
}

let origin: CGPoint = CGPoint(x: 0, y: 0)
let point: CGPoint = CGPoint(x: 1, y: 1)

let distance: Double = distanceBetweenPoint(origin, toPoint: point)

//“虽然在数学上和最后的程序运行上都没什么问题，但是阅读和维护的时候总是觉得有哪里不对。因为我们没有将数学抽象和实际问题结合起来，使得在阅读代码时我们还需要在大脑中进行一次额外的转换：CGPoint 代表一个点，而这个点就是我们在定义的坐标系里的位置；Double 是一个数字，它代表两个点之间的距离。
//“如果我们使用 typealias，就可以将这种转换直接写在代码里，从而减轻阅读和维护的负担：

typealias Location = CGPoint
typealias Distance = Double
func distanceBetweenPoint(location:Location, toLocation: Location) ->Distance  {
    let dx = Distance(location.x - toLocation.x)
    let dy = Distance(location.y - toLocation.y)
    return sqrt(dx * dx + dy * dy)
}
let origin1: Location = Location(x: 0, y: 0)
let point1: Location = Location(x: 1, y: 1)
let distance1: Distance = distanceBetweenPoint(origin, toLocation: point)

//“同样的代码，在 typealias 的帮助下，读起来就轻松多了。可能单单这个简单例子不会有特别多的体会，但是当你遇到更复杂的实际问题时，你就可以不再关心并去思考自己代码里那些成堆的 Int 或者 String 之类的基本类型到底代表的是什么东西了，这样你应该能省下不少脑细胞。

//“对于普通类型并没有什么难点，但是在涉及到泛型时，情况就稍微不太一样。首先，typealias 是单一的，也就是说你必须指定将某个特定的类型通过 typealias 赋值为新名字，而不能将整个泛型类型进行重命名。下面这样的命名都是无法通过编译的：
#if false
//这是错误代码
class Person<T> {}
typealias Worker = Person
typealias Worker = Person<T>
//typealias Worker<T> = Person<T>
#endif

//“一旦泛型类型的确定性得到保证后，我们就可以重命名了：
class Person1<T> {}
typealias WorkId = String
typealias Worker = Person1<WorkId>



//============== 下面没看懂？？
//“另一个值得一提的是 Swift 中是没有泛型接口的，但是使用 typealias，我们可以在接口里定义一个必须实现的别名，这在一定范围内也算一种折衷方案。比如在 GeneratorType 和 SequenceType 这两个接口中，Swift 都用到了这个技巧，来为接口确定一个使用的类似泛型的特性：
protocol GeneratorType {
    typealias Element
    mutating func next() -> Self.Element?
}
protocol SequenceType {
    typealias Generator: GeneratorType
    func generate() -> Self.Generator
}
//“在实现这些接口时，我们不仅需要实现指定的方法，还要实现对应的 typealias，这其实是一种对于接口适用范围的抽象和约束。












