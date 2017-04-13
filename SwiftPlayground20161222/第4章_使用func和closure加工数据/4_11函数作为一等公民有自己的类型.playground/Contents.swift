//: Playground - noun: a place where people can play

import UIKit

//: ### Function
//: #### Return value
func multipleOf(_ multiplier: Int, _ andValue: Int) ->Int {
    return multiplier * andValue
}
var m = multipleOf(5, 10)
//除了返回单个类型之外，swift还允许我们通过tuple来返回多个类型:
func tableInfo() ->(row: Int, column: Int) {
    return (4, 4)
}
var table = tableInfo()
table.row

//如果函数的返回值有可能为空，就让函数返回一个optional：
func string2Int(str: String) -> Int? {
    return Int(str)
}
var n = string2Int(str: "123")
type(of: n)

//: #### Function Type  函数类型本身
//和Int，String，tuple这些类型一样，函数本身也是一个类型。
//   函数           函数的类型
// multipleOf  (Int, Int) ->Int
//tableInfo    () ->(Int, Int)
//string2Int   (String) -> Int?
var f1: (Int, Int) ->Int = multipleOf   //使用函数类型来定义一个变量
var f2 = tableInfo
var f3 = string2Int
//使用函数变量：
f1(5, 10)
f2()
f3("100")

//也可以在函数参数，或者返回值的位置来使用函数类型。
//参数传入一个函数类型：
func execute(fn: (String) ->Int?, _ fnParam: String) {
    fn(fnParam)
}
execute(fn: f3, "1000")

//返回一个函数类型：
func increment(n: Int) ->Int {
    return n + 1
}
func decrement(n: Int) ->Int {
    return n - 1
}
typealias op = (Int)-> Int
func whichOne(n: Bool) ->op {
    return n ? increment : decrement
}
var one = 1
var oneToTen = whichOne(n: one < 10)
while one < 10 {
    one = oneToTen(one)
}

//在这里，如果觉得函数的类型写在函数的参数或者返回值的位置让代码变得比较混乱，还可以使用另一个特点：typealisa  :
#if false
typealias op = (Int)-> Int
func whichOne(n: Bool) ->op {
    return n ? increment : decrement
}
#endif

//: Nested function   内嵌函数
#if false
    func whichOne(n: Bool) ->op {
        func increment(n: Int) ->Int {
            return n + 1
        }
        func decrement(n: Int) ->Int {
            return n - 1
        }
        return n ? increment : decrement
    }
#endif




