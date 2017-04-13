//: Playground - noun: a place where people can play

import UIKit


//: #### optional chaining   `?.`   的秘密解密
//当我们通过某个类对象的属性或者方法时，使用Optional chaining，可以在不牺牲安全性的情况下，让代码变得简单
enum Type {
    case CREDIT
    case DEPOSIT
}
class BankCard {
    var type: Type = .CREDIT
}
class Person {
    var card: BankCard?
    init(card: BankCard? = nil) {
        self.card = card
    }
    
}
let nilPerson: Person? = nil
let noCardPerson:Person? = Person()
let creditCarPerson: Person? = Person(card: BankCard())
nilPerson?.card?.type
noCardPerson?.card?.type
creditCarPerson?.card?.type

//这里，如果把`?.`当作普通的操作符来理解，无非就是有2个操作数的操作符，左边的操作数就是某个类型`T`的optional，而右边的操作数则是生成某个新类型optional的closure，这样说可能有点抽象，我们看代码：
//先定义一个新的操作符：
infix operator => : optionalReplace
precedencegroup optionalReplace {
    associativity: left
}
func =><T, U>(opt: T?, f: (T) ->U?) ->U? {
    switch opt {
    case .some(let value):
        return f(value)
    case .none:
        return .none
    }
}
//对于optional，本质上就是包含`.some`和`.none`的enumation
//L nilPerson: Person?
//R { $0.card }
nilPerson=>{ $0.card }=>{ $0.type }
noCardPerson=>{ $0.card }=>{ $0.type }
creditCarPerson=>{ $0.card }=>{ $0.type }
//为什么使用optional chaining是安全的？因为对于noCardPerson以及nilPerson来说，`=>`操作符只是会简单地返回nil，并不会去尝试调用`f(value)`。实际上，除了使用`?.`操作符实现optional chaining之外，optional自身就提供了一个和`=>`类似的方法，叫做`flatMap`。当optional为nil时，返回nil，否则就返回对象的值。
//看一个例子：
nilPerson.flatMap({ $0.card}).flatMap({$0.type})
noCardPerson.flatMap({ $0.card}).flatMap({$0.type})
creditCarPerson.flatMap({ $0.card}).flatMap({$0.type})

//这时分别点开noCardPerson和creditCarPerson，就可以发现，他们和使用optional chaining的结果是一样的。这就是optional chaining所有的秘密，本质上它就是一个函数调用，而`?.`这样的操作符就像一个语法糖，让代码看上去显得更为简洁和统一。
//另一个容易让人困惑的概念：inpresitive unwrap optional



