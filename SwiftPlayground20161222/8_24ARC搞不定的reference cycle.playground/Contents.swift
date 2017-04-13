//: Playground - noun: a place where people can play

import UIKit

//: #### ARC - automatic reference counting
//swift使用`automatic reference counting`为我们搭理内存，但是并不代表它面对任何情况都足够聪明，尤其是当对象之间存在相互引用时，更是容易由于循环引用而导致内存无法释放，swift为我们提供了一系列的语言机制来处理循环引用，而我们也应该时刻保持警惕，来避免内存泄露。
//为了理解ARC是如何工作的，先定义一个类：
class Person {
    let name: String
    var apartment: Apartment?   //(***1)
    //为了方便观察到person对象的构造和销毁，分别定义构造和析构函数
    init(name: String) {
        self.name = name
        print("\(name) is being initialized.")
    }
    
    deinit {
        print("\(name) is being deinitialized.")
    }
}

//(***1)
class Apartment {
    let unit: String
    var tenant: Person?     //不是每一个房间都有房客，所以是Optional
    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is being initialized.")
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized.")
    }
}

//: Strong reference 强引用
//强引用引用的对象存活在内存里。
#if false
var ref1: Person?
var ref2: Person?
ref1 = Person(name: "Mars") //Person的引用计数是1
ref2 = ref1                 //Person的引用计数变为了 2
ref1 = nil                  //Person的引用计数为1
ref2 = nil                  //Person的引用计数为0,此时可看到Person的deinit被调用了
#endif

//当不同类对象存在相互引用时，指向彼此的`Strong reference`就会导致循环引用，使得ARC无法释放它们中的任何一个。
//看一个例子：(***1)
var mars: Person? = Person(name: "Mars")
var apt11: Apartment? = Apartment(unit: "11")
//添加下面2句代码后，Person和Apartment的析构函数都没有被调用，这是因为这样创建了Person和Apartment对象后，它们的关系这样的，只有mars和apt11
mars!.apartment = apt11
apt11?.tenant = mars

mars = nil
apt11 = nil






