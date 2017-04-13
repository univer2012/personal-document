//: Playground - noun: a place where people can play

import UIKit

struct Point {
    var x = 100.0
    var y = 100.0
}
class PointRef {
    var x: Int = 100
    var y: Int = 100
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
enum Direction: Int {
    case EAST = 2
    case SOUTH = 4
    case WEST = 6
    case NORTH = 8
}

//: Stored properties   存储属性
//真正存储值的
/*
 有一下特点：
 1、可以使用var 或 let 把`Stored properties`变成变量或常量，
 2、自定义类型的init方法要保证每一个`Stored properties`都被正常的初始化
 3、我们可以在定义`properties`时就指定初始值
 4、当我们创建自定义对象时，对象的每一个`Stored properties`都实际占据内存空间，每一个`Stored properties`都使用`对象.property`的方式来读取值:
 pt.x
 都使用 `对象.property = 值`的方式来赋值
 pt.x = 100
 5、只有struct和class可以定义`Stored properties`，而enum是不可以的
 */
let pt = PointRef(x: 10, y: 10)
pt.x
pt.x = 100

//有些属性是计算出来的，而不是一成不变的，管这样的属性叫做`Computed property`
//: #### Computed property   计算属性
//用来表示对象的某种属性，但它的值在每次访问时要被计算出来，而不是从内存中读取出来。
struct MyRect {
    var origin: Point
    //Property observer
    var width: Double {
        //如果想在属性被赋值之前得到通知，我们可以这样：
        willSet(newWidth) {
            //newWidth = abs(newWidth)        //'newWidth' is a 'let'constant
            print("width will be updated")
        }
        //这是属性赋值后我们得到通知的办法，其中oldValue代表赋值前属性的值
        didSet(oldValue) {
            if width <= 0 {
                width = oldValue
            }
                //如果想让矩形是正方形
            else {
                self.height = width
            }
        }
        //说明：无论是newWidth还是oldValue，都是常量，不能在`willSet`和`didSet`里修改它们。
        //另外一点要说明的是，在属性的`didSet`方法里面，可以直接使用属性的名字来访问对应的属性本身，但是当我们访问其他属性时，必须使用     `self`关键字
    }
    var height: Double
    //计算属性
    var center: Point {
        get {
            let centerX = origin.x + self.width / 2
            let centerY = origin.y + self.height / 2
            return Point(x: centerX, y: centerY)
        }
        //把它传入一个参数newCenter，在set内部来处理当一个`Computed property`被赋值时，我们如何把它拆分成多个`Stored properties`。在这个例子里，当对center赋值时，我们有很多方式把它拆分成origin、width和height。例如，一个新的center可能是由于宽高不变，移动了origin造成的；也有可能是由于origin不变，但是改变了宽或高造成的，因此当我们把一个`Computed property`拆分成多个`Stored properties`时，总是要对拆分的过程做一些假设。在我们例子里，假设宽高不变，移动了origin，因此在center的set方法里，我们要根据newCenter来计算新的origin：
        set(newCenter) {
            self.origin.x = newCenter.x - self.width / 2
            self.origin.y = newCenter.y - self.height / 2
        }
    }
}
let pt11 = Point(x: 1, y: 1)
var rect1 = MyRect(origin: pt11, width: 200, height: 100)
//let rect1 = MyRect(origin: pt11, width: 200, height: 100)
//这样就能读到矩形的中心了：
rect1.center
//当我们把rect1改成变量，然后修改height值时，就可以发现rect1.center会自动发生变化：
rect1.height = 200
rect1.center


//可以对`Computed property`赋值吗？答案是：可以的。但是由于`Computed property`并不实际占用内存存储，因此我们要把传入的值拆给class个各种`Stored properties`,并且，一旦需要给`Computed property`赋值，我们就需要在定义它时明确它的`get`和`set`方法.
//使用set关键字来指定`Computed property`被赋值时采取的动作

//
rect1.origin
var o1 = rect1.center
o1.x += 100
rect1.center = o1
rect1.origin




//如果想在`Stored properties`在被赋值之前，自动过滤掉非法值，或者在`Stored properties`被赋值后，自动更新相关的其他property，怎么办呢？为此，swift提供了一个语言机制：`Property observer`
//: #### `Property observer`
rect1.width = 300

//如果想让width >= 0, 我们可以这样：
rect1.width = -300
rect1.width
rect1.height

//特别说明：只有当我们对一个已经完整初始化过的对象去修改它的属性时，willSet和didSet才会生效。在一个自定义类型的init方法里，我们也会对属性赋值，但是在这个方法里，willSet和didSet是不生效的。





//: #### Lazy property
class Account {
    let name: String
    //为了防止内存泄露，我们要在closure里把self定义为unowned ，然后用 `in`来表示代码的开始。
    lazy var greeting: String = { [unowned self] in
        print("greeting is initialized.")
        return "Hello " +  self.name }()
    init(name: String) {
        self.name = name
    }
}
let mars = Account(name: "Mars")
//greeting = nil
//如果希望Account有一个能够根据name自动生成用户问号信息的属性，我们就可以使用`lazy property`
/*
 有几个特点：
 1、greeting是不用在init方法里初始化的
 2、只有真正访问greeting时，它的值才真正被生成出来，
 3、和`property`不同的是，`lazy property`只在第一次被访问时通过closure初始化一次，当我们多次访问`lazy property`时，greeting是不会被反复地初始化的。(控制台中只有一句"greeting is initialized.")
 */
//通常使用`lazy property`来处理对象初始化过程中耗时非常长，但是不一定要使用的部分。
mars.greeting
mars.greeting
mars.greeting


//还有一些属性是隶属于所有对象的。
