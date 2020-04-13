//
//  main.swift
//  Tip16初始化方法顺序
//
//  Created by huangaengoln on 16/4/10.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")

//“与 Objective-C 不同，Swift 的初始化方法需要保证类型的所有属性都被初始化。所以初始化方法的调用顺序就很有讲究。在某个类的子类中，初始化方法里语句的顺序并不是随意的，我们需要保证在当前子类实例的成员初始化完成后才能调用父类的初始化方法：
class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        super.init()
        name = "tiger"
    }
}
/*
 “一般来说，子类的初始化顺序是：
    1.设置子类自己需要初始化的参数，power = 10
    2.调用父类的相应的初始化方法，super.init()
    3.对父类中的需要改变的成员进行设定，name = "tiger"
 
 其中第三步是根据具体情况决定的，如果我们在子类中不需要对父类的成员做出改变的话，就不存在第 3 步。而在这种情况下，Swift 会自动地对父类的对应 init 方法进行调用，也就是说，第 2 步的 super.init() 也是可以不用写的 (但是实际上还是调用的，只不过是为了简便 Swift 帮我们完成了)。这种情况下的初始化方法看起来就很简单：
 */
class Cat1 {
    var name: String
    init() {
        name = "cat"
    }
}
class Tiger1: Cat1 {
    let power: Int
    override init() {
        power = 10
        //如果我们不需要改变name的话
        //虽然我们没有显示地对super.init()进行调用
        // 不过由于这是初始化的最后了，Swift替我们自动完成了
    }
}














