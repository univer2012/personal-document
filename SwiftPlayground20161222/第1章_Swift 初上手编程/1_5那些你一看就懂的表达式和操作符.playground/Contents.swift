//: Playground - noun: a place where people can play

import UIKit


//: #### Basic assignment 基本的复制操作
let a = 20
var b = 10

//: #### Basic arithmetic operation   基本的数据操作
let sum = a + b
let sub = a - b
let mul = a * b
let div = a / b
let mod = a % b
//说明：在C和OC中，去模操作只能用于整数的，比如：
let mod1 = 8 % 2
/*
 +---+---+---+---+
 | 2 | 2 | 2 | 2 |
 +---+---+---+---+
 |        8      |
 +---+---+---+---+
 */
//而在Swift里面，取模操作是可以用于浮点数的，例如：
//let mod2 = 8 % 2.5
/*
 +-----+-----+-----+-----+
 | 2.5 | 2.5 | 2.5 | 2.5 |
 +-----+-----+-----+-----+
 |        7.5      | 0.5 |
 +-----+-----+-----+-----+
 |          8            |
 +-----+-----+-----+-----+
 */

//: #### Compound assignment  复合操作
b += 10 // b = b + 10
b -= 10 // b = b - 10
b *= 10 // b = b * 10
b /= 10 // b = b / 10
b %= 10 // b = b % 10


//: #### Self increment and decrement  自增和自减操作
//var ppb = ++b
//var bpp = b++
//--b
//b--


//: #### Cpmparsion  比较操作
let isEqual = sum == 10
let isNotEqual = sum != 10
let isGreater = sum > 10
let isLess = sum < 10
let isGe = sum >= 10
let isLe = sum <= 10
//swift还提供了额外的2个操作：
//: Identity operator    身份比较
//   ===     指向相同的对象
//   !==     不指向相同的对象


//: #### Tenary conditional Operator 三元条件操作符
/*
 * if condition {
 * expression1
 * } else {
 * expression2
 * }
 */
let isSumEqualToTen = isEqual ? "YES" : "NO"


//swift中特有的操作：
//: #### Nil coalescing Operator
// opt != nil ? opt! : b
var userInput: String? //= "A user input"
//当我们把userInput变量赋值给其它变量，并且当userInput的值为空，我们要提供一个默认值的时候，我们可以这样：
let value = userInput ?? "A default input"


//Swift中特有的操作：
//: #### Range Operator
//: Closed range opeator     闭区间
//  begin...end      [begin, end]
for index in 1...5 {
    print(index)
}

//:Half-open range operator 半开半闭区间
// begin...<end     [begin, end)
for index in 1..<5 {
    print(index)
}


//: #### Logic operator   逻辑操作符

let logicNot = !isEqual             //逻辑非
let logicalAnd = isEqual && isLess  //逻辑与
let logicOR = isGreater || isLess   //逻辑或
//swift 会从左到右运算表达式：
let logicOR1 = isGreater || isLess && isLe







