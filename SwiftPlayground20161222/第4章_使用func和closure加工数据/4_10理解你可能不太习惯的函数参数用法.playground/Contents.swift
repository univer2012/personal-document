//: Playground - noun: a place where people can play

import UIKit

//: ### Function
//: #### The most simple function
func printName() {
    print("My name is Mars.")
}
printName()

//: #### Function param
// name: Type
func multipleOfTen(multiplier: Int) {
    print("\(multiplier) * 10 = \(multiplier * 10)")
}
multipleOfTen(multiplier: 10)
//多个入参：
func multipleOf(_ multiplier: Int, andValue: Int) {
    print("\(multiplier) * \(andValue) = \(multiplier + andValue)")
}
multipleOf(5, andValue: 10)

//: param name  
//使用的row和column是函数的内部名字，也就是innername。实际上每个函数的参数还有一个外部名字，叫做outername，默认时，innername和outername是一样的，所以不需要额外指定outername

func createTable(rowNumber row: Int = 10, colNumber column: Int = 10) {
    print("Table: \(row) x \(column)")
}
createTable(rowNumber: 10, colNumber: 10)
//如果希望调用函数时，忽略掉指定的outername，那么可以在定义函数时，在指定的参数名outername的位置使用一个下横线。

//: Default value  指定参数的默认值
createTable()

//: Varifadic param 让函数参数支持可变参数列表
func arraySum(_ number: Double...) {
    //number: [Double]
    var sum: Double = 0.0
    for i in number {
        sum += i
    }
    print("sum: \(sum)")
}
arraySum(1,2,3,4,5,6)
arraySum(1,2,3,4)

//: Constant and variable param  函数的常量参数和变量参数
//在Swift里，函数的参数默认是常量，是不可以被修改的：
#if false   //在Swift3中已经失效
func increment(var value: Int) {
    value += 1 //'value' is a 'let' constant
}
    //通常我们在函数内部修改参数值，是因为我们需要对传入的参数进行修改
var m = 10
increment(m)
m           //发现m的值还是10
#endif


//: inout param   函数参数的另一个特性
func increment(_ value: inout Int) {
    value += 1
}
//通常我们在函数内部修改参数值，是因为我们需要对传入的参数进行修改
var m = 10
//要传入的是引用，而不是变量本身
increment(&m)
//这样就可以看到m值被函数修改了











