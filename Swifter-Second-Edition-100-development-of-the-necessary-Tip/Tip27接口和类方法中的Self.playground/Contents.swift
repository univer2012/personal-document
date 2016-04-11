//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

//“我们在看一些接口的定义时，可能会注意到出现了首字母大写的 Self 出现在类型的位置上：
protocol IntervalType {
    //...
    ///Return 'rhs' clamped to 'self'. The bounds of the result,even
    /// if it is empty, are always within the bounds of 'self'
    func clamp(intervalToClamp: Self) ->Self
    
    //...
}
//“比如上面这个 IntervalType 的接口定义了一个方法，接受实现该接口的自身的类型，并返回一个同样的类型。这么定义是因为接口其实本身是没有自己的上下文类型信息的，在声明接口的时候，我们并不知道最后究竟会是什么样的类型来实现这个接口，Swift 中也不能在接口中定义泛型进行限制。而在声明接口时，我们希望在接口中使用的类型就是实现这个接口本身的类型的话，就需要使用 Self 进行指代。

//“但是在这种情况下，Self 不仅指代的是实现该接口的类型本身，也包括了这个类型的子类。从概念上来说，Self 十分简单，但是实际实现一个这样的方法却稍微要转个弯。为了说明这个问题，我们假设要实现一个 Copyable 的接口，满足这个接口的类型需要返回一个和接受方法调用的实例相同的拷贝。一开始我们可能考虑的接口是这样的：
protocol Copyable {
    func copy() ->Self
}

//“这是很直接明了的，它应该做的是创建一个和接受这个方法的对象同样的东西，然后将其返回，返回的类型不应该发生改变，所以写为 Self。然后开始尝试实现一个 MyClass 来满足这个接口：
#if false
class MyClass: Copyable {
    var num = 1
    func copy() -> Self {
         //TODO:返回什么？
        //return
    }
}
#endif

//“我们一开始的时候可能会写类似这样的代码：
#if false
//这是错误代码
class MyClass1: Copyable {
    var num = 1
    func copy() ->Self {
        let result = MyClass()
        result.num = num
        return result
    }
}
#endif
//“但是显然类型是有问题的，因为该方法要求返回一个抽象的、表示当前类型的 Self，但是我们却返回了它的真实类型 MyClass，这导致了无法编译。也许你会尝试把方法声明中的 Self 改为 MyClass，这样声明就和实际返回一致了，但是很快你会发现这样的话，实现的方法又和接口中的定义不一样了，依然不能编译。

//“为了解决这个问题，我们在这里需要的是通过一个和当前上下文 (也就是和 MyClass) 无关的，又能够指代当前类型的方式进行初始化。希望你还能记得我们在对象类型中所提到的 dynamicType，这里我们就可以使用它来做初始化，以保证方法与当前类型上下文无关，这样不论是 MyClass 还是它的子类，都可以正确地返回合适的类型满足 Self 的要求：
#if false
class MyClass2: Copyable {
    var num = 1
    func copy() -> Self {
        let result = self.dynamicType.init()
        result.num = num
        return result
    }
}
#endif
//Constructing an object of class type 'Self' with a metatype value must use a 'required' initializer


//“但是很不幸，单单是这样还是无法通过编译，编译器提示我们如果想要构建一个 Self 类型的对象的话，需要有 required 关键字修饰的初始化方法，这是因为 Swift 必须保证当前类和其子类都能响应这个 init 方法。在这个例子中，我们添加上一个 required 的 init 就行了。最后，MyClass 类型是这样的：
class MyClass3: Copyable {
    var num = 1
    func copy() -> Self {
        let result = self.dynamicType.init()
        result.num = num
        return result
    }
    
    required init() {
        
    }
}

//“我们可以通过测试来验证一下行为的正确性：
let object = MyClass3()
object.num = 100
let newObject = object.copy()
object.num = 1
print(object.num)       //1
print(newObject.num)    //100

//“而对于 MyClass 的子类，copy() 方法也能正确地返回子类的经过拷贝的对象了。


//“另一个可以使用 Self 的地方是在类方法中，使用起来也十分相似，核心就在于保证子类也能返回恰当的类型。

















