//: Playground - noun: a place where people can play

import UIKit

class Point2D {
    var x: Double
    var y: Double
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    convenience init(pt: (Double, Double)) {
        self.init(x: pt.0, y: pt.1)
    }
    
    convenience init?(strPt: (String, String)) {
        let x = Double(strPt.0)
        let y = Double(strPt.1)
        
        if x == nil || y == nil {
            return nil
        }
        self.init(pt:(x!, y!))
    }
    
    convenience init(val: Double) {
        self.init(x: val, y: val)
    }
    
}

//默认情况下，派生类不从基类继承任何的init方法，基类的init方法只在有限的条件下被派生类自动地继承。我们基于上一个视频的Point2D来看一个例子：
//从Point2D派生一个用于表示3维空间的点：
class Point3D: Point2D {
    var z = 0.0//: Double
    
    init(x: Double, y: Double, z: Double) {
        self.z = z
        super.init(x: x, y: y)
        //***4
        round(self.x)
        round(self.y)
        round(self.z)
    }
    
    override init(x: Double, y: Double) {
        super.init(x: x, y: y)
    }
    //***3
    convenience init(val: Double) {
        self.init(x:val, y: val, z: val)
    }
}
/*这是Point3D会从Point2D继承到什么呢？
 答案是，如果派生类没有定义任何的`Designated initializer`，那它将自动继承所有积累的`Designated initializer`。但是即便Point3D继承了Point2D的`Designated initializer`，它的var z 仍旧是无法初始化的。
 现在，Point3D还不会从Point2D来继承这个init方法，打开控制台可以看到swift编译器的错误提示。因为 z 没有初始值，因此它阻止了initializer的合成。
 因此，如果想让Point3D继承Point2D的init方法，唯一的办法就是让 z 有一个初始值。
 var z = 0.0
 
 由于Point3D没有定义任何的`Designated initializer`，因此它就继承了Point2D所有的init方法。
 
 于是就可以这样定义3维坐标原点：
 */
let origin3D = Point3D(x: 0, y: 0)


//如果一个派生类继承了所有的基类的`Designated initializer`，那么它也将自动地继承基类所有的`Convenience initializer`。
//在一个派生类里面，对基类的`Designated initializer`方法的实现，可以是我们手工编写的，也可以像Point3D这样，是从基类继承得来的。
//因此，一个派生类自动继承了基类的`Designated initializer`，它自然自动继承基类所有的`Convenience initializer`。
let point3D11 = Point3D(pt: (1.0, 1.0))
let point3D22 = Point3D(strPt: ("2.0", "2.0"))
let point3D33 = Point3D(val: 3.0)
//这些都是Point3D从Point2D中继承得来的`Convenience initializer`。


//如果我们想定义3维空间中的点。我们必须给Point3D手工编写一个`Designated initializer`：
//必须先初始化派生类自身的成员数据，然后使用super关键字调用基类的init方法，来初始化基类的数据成员。
//会看到有些Point3D对象创建失败了，这是因为如果在派生类中自定义了自己的`Designated initializer`，代表我们要明确控制派生类对象的构建过程，这时，派生类就不会自动地从基类去继承任何的init方法了。


//如果我们还希望Point3D继承Point2D的`Convenience initializer`，我们只需要重载Point2D的`Designated initializer`就可以了。
//在重载的init方法内部，只是把调用转化为super.init就可以了。
//这时我们会看到，又可以使用这样的`Convenience initializer`来创建Point3D对象。


//关于重载基类的init方法，有一个特例，就是当我们重载基类的`Convenience initializer`时，是不需要使用`override`关键字的，例如：(***3)
//实现非常简单，我们只是把调用传递给自己的init方法。


//总结下Point3D和Point2D所有的init方法之间的关系
//首先，由于Point3D实现了所有的Point2D的`Designated initializer`，因此就继承了所有Point2D的`Convenience initializer`；
//然后，在Point3D里面，我们重载了其中的一个`Convenience initializer`。
//无论是Point3D还是Point2D里面，所有的`Convenience initializer`最终都一定要把调用转化到自己类的`Designated initializer`里；
//而派生类中的所有`Designated initializer`最终一定要调用基类的`Designated initializer`类完成基类的初始化过程。



//Two-phase initialization
//这是swift为了确保派生类和基类的数据成员都能够被正确地初始化而引入的一种机制。
//Two-phase的第一个阶段是从派生类到基类自下而上地让每一个属性都有初始值，因此，在Point3D的init方法里，我们必须先对 z 赋值，然后再调用父类的init方法。
//而第2个phase是指，当一个类的所有数据成员都有初始值时，我们才能对它们做进一步的操作。比如我们希望对x、y、z取整：(***4)
//如果把这3行写在super.init前面，编译器就会告诉我们发生了错误。
//我们在super.init初始化之前是不能访问它的。

