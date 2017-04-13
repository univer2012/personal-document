//: Playground - noun: a place where people can play

import UIKit

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
var mars: Person? = Person(name: "Mars")
var apt11: Apartment? = Apartment(unit: "11")
mars!.apartment = apt11
apt11?.tenant = mars

mars = nil
apt11 = nil



//要解决对象间循环引用代理的内存泄露的问题，根据一个类的数据成员是否允许为nil，我们有不同的处理方法。

//上面的例子中，tenant和apartment都允许为nil，我们可以使用`weak reference`来解决问题
//: #### weak reference
//可以把一个`weak reference`就理解为一个普通的Optional，



