//: Playground - noun: a place where people can play

import UIKit
//: Playground - noun: a place where people can play
struct PointVal {
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    mutating func moveX(x: Int) {
        self.x = x
    }
    
}
class PointRef {
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    func move(x: Int) {
        self.x = x
    }
}

//都可以自定义类型，都可以拥有属性，也都可以拥有方法，而class作为一个引用类型，具有很多struct不具备的表达能力。这些能力都源于他们要表达的内容不同，`class`表示一个具体的对象，而`struct`只表达一个普通的值。
/*区别：
 * 1、 class是没有默认的init方法的，如果我们不指定它，编译器会报错。但是Swift为`struct`提供了默认的init方法 。为什么会这样？
 是因为`class`并不是简单的值，Swift要求我们必须明确通过init来表达构建一个对象的过程；相反，`struct`只是一个简单地值的概念，如果我们没有特别说明值的构建过程，一个值的初始化当然是把每一个member都按顺序初始化。
 * 2、 第2个区别是：对于常量的理解是不同的 ：
 */
let p1 = PointVal(x: 0, y: 0)
let p2 = PointRef(x: 0, y: 0)
//p1.x = 10  //Cannot assign to property:'p1'is a 'let'constant p1是常量
p2.x = 10
//这是因为p1作为值类型，它的常量当然是值不能被改变；但是p2作为一个引用类型，常量对它的含义是，它不能再指向其它对象，例如：
let p3 = p2
//p2 = p3    //Cannot assign to value: 'p2'is a 'let' constant




//: Identity operator    用于引用类型的操作符
//上例中，尽管p2和p3都指向了相同的坐标点，但是p2和p3却不指向相同的对象。为了能够区分相同的值，和相同的引用，Swift为我们提供了`Identity operator`
//判断p2和p3是否指向相同的对象：
if p2 === p3 {
    print("They are the same object")
}
var pb = PointRef(x: 0, y: 0)
if pb !== p3 {
    print("They are not the same object")
}


//* 3、 struct和class在定义方法时表现的不同。`struct`的方法默认是不能修改它的member的，在struct里面，必须使用`mutating`来修饰修改member的方法。在`class`却完全没有这样的限制。这是因为作为一个值类型，它所代表的坐标点的值和我们平时使用的`123`这样的数字是没有本质的区别的，作为程序中使用的字面值，默认情况下，它们当然不应该有能够修改自身值的方法；
//但是作为类对象来说，它的数据成员只是代表了一个对象自身的属性，我们也当然可以提供修改这些属性的方法。


//* 4、 值类型和引用类型在赋值语义上的区别。
//当我们复制一个值类型变量时，
var pa = PointVal(x: 0, y: 0)
var p4 = pa
p4.x = 10   //p4.x = 10
pa.x        //pa.x = 0

var p5 = p2
p2.x = 10   //p2.x = 10
p5.x        //p5.x = 10
//这些就是作为值类型的struct和作为引用类型的class的最基本的区别。





