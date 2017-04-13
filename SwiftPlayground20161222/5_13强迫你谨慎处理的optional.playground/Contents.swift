//: Playground - noun: a place where people can play

import UIKit

/*
//: ### Optional
 
 + There's a value _x
 
 _or_
 
 + There's nothing at all
 
 */
//: 在OC中，使用nil表示对象的值不存在，使用NSNotFound表达一个标量类型不存在，或者使用-1、0、""的方式来表达类似语义上变量值有可能为空的情况。
//Swift中，无论任何类型，要表达一个值有可能为空时，就会统一的使用 optional

//: ####Define an optional variable
//: String -> Int
let possibleNumber = "123"
//当我们尝试把一个字符串转换为一个整数时，这样的转换是有可能失败的，因此当我们用一个变量来保存这样的转换结果时，可以看到这个变量的类型是是一个Optional<Int>
var convertResult = Int(possibleNumber)
print(convertResult)
type(of: convertResult)

//除了使用type infrelence来定义optional之外，还可以手动指定optional变量的类型：
var x: Int?
var address: String?
var successRate: Double?
//所有这样定义的变量值都会被自动设置为nil
//convertResult = nil

//只能把nil赋值给optional，而不能把nil：
#if false
var m = 10
m = nil
    //因此在swift中，访问普通类型的变量总是安全的，并不会因为访问到了一个值为空的普通变量，而引发运行时错误，进而导致程序闪退。
#endif

//: #### Access optional   访问optional
//optional的值有可能为空，因此不能在swift中直接访问optional的值，而通常先使用`if`对optional进行判断：

//: Force unwrapping
if convertResult != nil {
    // Force unwrapping
    print(convertResult!)
}
//通过在optional后面添加一个`!`形式来访问optional的值。这样访问optional值的方法叫做`Force unwrapping`。需要说明的是，如果不是先对optional做是否为nil检查，而直接使用`Force unwrapping`，是可能会导致运行时错误的:
#if false
print(x!) //会报错
#endif

//: 用 Optional binding 的方式来访问optional的值
//通过在if语句里定义一个常量或者变量，并且把它和optional变量绑定起来，这样当optional中的值不为空时，就可以在if语句里面直接访问optional的值。
if let number = convertResult {
    print(number)
    
}
else {
    print("Convert result is nil")
}

//需要在if语句里面修改optional值时，可以把一个变量和optional绑定起来，之后就可以修改number：
if var number = convertResult {
    number = number + 1
    print(number)
    print(convertResult)
//    let sum = convertResult + 1  //会报错
    let sum = number + 1 //正确
}
else {
    print("Convert result is nil")
}
//需要说明的是，所有对number的操作，并不会影响到convertResult的值.
//需要强调的是，一个`Optinal<Int>`并不是一个`Int`,并不能把一个`Optinal<Int>`和`Int`直接相加


//: #### Implicitly Unwrapped Optional   隐式打开可选
var possibleString: String! = "A dangerous way" //nil
print(possibleString)
possibleString + " Use it with caution"
//通常，我们只会在一定会被赋值的环境里，或者我们会为了解决对象之间循环引用计数等问题中，才会使用`Implicitly Unwrapped Optional`
//除了能够自动地去获取optional的值之外，`Implicitly Unwrapped Optional`也支持`Force unwrapping`和`Optional binding`。
//而在日常编码中，只要我们使用的变量有可能为空，就应该一直使用普通的Optional，而不要使用`Implicitly Unwrapped Optional`







