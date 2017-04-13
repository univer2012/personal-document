//: Playground - noun: a place where people can play

import UIKit

//: # 经过改良加工的switch … case ...

//: switch
//: ### Switch in Swift
//: Basic usage
let someChar: Character = "a"
switch someChar {
case "a":
    print("vowel char \(someChar)")
case "e":
    print("vowel char \(someChar)")
case "i":
    print("vowel char \(someChar)")
case "o":
    print("vowel char \(someChar)")
case "u":
    print("vowel char \(someChar)")
default:
    print("vowel char \(someChar)!")
}

/*
 和C语言不同的是，无需在switch后面()把someChar括起来，另外也不需要使用break来申明一个case的结束。这意味着swift中，每个case是不会贯通的。
 因此在swift中，下面语句是无法通过编译的：
 switch someChar {
 case "a":
 case "e":
 case "i":
 case "o":
 case "u":
 print("vowel char \(someChar)")
 default:
 print("vowel char \(someChar)!")
 }
 
 我们只能通过这样的方式来实现：
 switch someChar {
 case "a" ,"e", "i", "o", "u":
 print("vowel char \(someChar)")
 default:
 print("vowel char \(someChar)!")
 }
 */

//: Interval
//使用case来匹配一个范围：
let number  = 10
switch number {
case 1..<10:
    print("Several")
case 10..<100:
    print("Dozens of")
case 100..<1010:
    print("Hundreds of")
default:
    print("Many")
}
//switch内部所有的case一定要覆盖switch后面表达式的所有情况。


//: tuple 在switch中使用tuple匹配多个变量
let point = (1, 1)
switch point {
case (0, 0):
    print("Point is at the origin")
case (_, 0):
    print("(\(point.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(point.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(point.0), \(point.1)) is inside the blue box.")
default:
    print("(\(point.0), \(point.1)) is outside the blue box.")
}

//value binding
//使用value binding来绑定tuple中某个位置的值，
//例子1：
switch point {
case (let x, 0):
    print("with the X value of: \(x)")
case (0, let y):
    print("with the Y value of: \(y)")
case (let x, let y):
    print("X: \(x), Y: \(y)")
}
//例2：
switch point {
case let (x, y) where x == y:
    print("\(point.0, point.1) is on y = x")
case let (x, y) where x == -y:
    print("(\(point.0, point.1) is on y = -x)")
case let (x, y):
    print("(\(point.0, point.1))")
}

//除了匹配tuple的各种用法之外，switch case还可以匹配swift中的枚举类型。


