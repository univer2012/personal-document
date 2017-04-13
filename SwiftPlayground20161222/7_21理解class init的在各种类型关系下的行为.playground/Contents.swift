//: Playground - noun: a place where people can play

import UIKit


//由于class引入了类型的继承关系，因此它的初始化过程要比struct复杂的多。为了保证一个class中，所有的数据成员都可以被初始化，swift引入了一系列特定的规则。
//定义平面中的一个点：
#if false
class Point2D {
    var x: Double
    var y: Double
    
}
#endif
//class在swift中没有默认的init方法。唯一让swift中提供init方法就是我们在类定义中对每一个数据成员手工指定一个初始值。比如:
class Point2D {
    var x: Double// = 0.0
    var y: Double// = 0.0
    //如果要定义不同的坐标点，就需要Point2D里面添加一个叫`Designated initializer` or `memberwise initializer`
    //一个`Designated initializer`，必须确保一个类的所有数据成员都被完整地初始化。
    init?(x: Double, y: Double) {
        if x < 0 || y < 0 {
            return nil
        }
        self.x = x
        self.y = y
        
    }
    
    //Convenience initializer
    convenience init(xy: (Double, Double)) {
        self.init(x:xy.0, y: xy.1)!
    }
    convenience init(val: Double) {
        self.init(x: val, y: val)!
    }
    //Failable initializer
    convenience init?(xyStr: (String, String)) {
        let x = Double(xyStr.0) //转换为的值的类型是    Double?
        let y = Double(xyStr.1)
        
        if x == nil || y == nil {
            return nil
        }
        
        self.init(xy: (x!, y!))
    }
    
}
//: #### Default   默认的init方法只能帮助我们生成固定值的default对象
//let origin = Point2D()

let pt11 = Point2D(x: 1.0, y: 1.0)
//大部分时候，一个class只有一个`Designated initializer`，它用来对每一个成员逐个进行初始化。

//如果要支持以下这2种方式：
let pt22 = Point2D(xy:(2.0, 2.0))
// y = x
let pt33 = Point2D(val: 3.0)
//我们就需要在Point2D里面添加另一种initializer。管这种initializer方法叫做`Convenience initializer`

//有时候对象的创建会因为参数的问题而创建失败，为了能处理这种情况，swift引入了第3种init方法。管它叫`Failable initializer`
//先来看一个例子
//假设要使用一个String类型的turple，来创建一个Point2D，
//let pt44 = Point2D(xyStr: ("4.0", "4.0"))

//如果我们传递的参数不能被转化为浮点数时，就会发生执行错误。对于这种情况，一个比较理想的处理方式就是，当参数传入不合法时，我们让pt44变成一个nil，这时就可以通过`Failable initializer`来帮助我们达成这个目的。定义一个`Failable initializer`方法，只需要在init后面加一个`?`即可
let pt44 = Point2D(xyStr: ("Four", "4.0"))
type(of: pt44)



//关于`Failable initializer`，我们要多说一点，就是当我们对一个`Designated initializer`使用failable时，这种用于表示创建失败的返回，必需要放在所有数据成员被初始化之后。例如要限制所有的x、y都大于等于0，必需把这样的if判断写在self.y赋值后面：



//如果把这样的判断写在self.x前面，就会看到编译器告诉我们有语法错误。为了能够看到这个错误，先要对代码做一些调整:
/*去掉x和y的默认值，直接声明类型；
 由于这个`Designated initializer`返回的是Optional，因此要把后面的使用中，要强制引用出来；
 这时就会看到，swift提示我们，语法错误了。这个错误提示告诉我们：当我们在initializer里面返回nil之前，一个class的所有properties都必须被初始化过，这也就是为什么当x、y设置了默认值0时，看不到这个错误的原因。
 
 //把一个class的初始化过程总结一下：
 所有的Convenience init方法之间是可以互相转换调用的，而所有的Convenience方法最终必须要到一个Designated init方法来初始化一个对象。
 
 当class之间存在继承关系时，Designated以及Convenience 的执行路径。以及派生类和基类所有数据成员的初始化过程。
 */




