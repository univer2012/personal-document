//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let emptyString = ""
let emptyString1 = String()

var swift = "Swift is fun."
//String是值类型
let swiftCopy = swift
print(swiftCopy)
//Copy on write

//: 字符串中的 字符
let charA: Character = "A"
let charB = "B"

for char in swift.characters {
    print(char)
}


//除了读取characters属性外，我们还可以使用character数组初始化一个字符串
let swiftInChar:[Character] = ["S", "w", "i", "f", "t"]
let swift1 = String(swiftInChar)

//使用字符串相加的方式来初始化字符串
let swift2 = swift + swift1

//String interpolation
//    \(expression)
let PI = 3.14
let message = "PI * 100 equals to \(PI * 100)"

//不能在插入的值中加入 \、 回车或者是括号


//: #### UNICODE
//Unicode Scalar
//可以这样使用Unicode标量：
let blingHeart = "\u{1F496}"
//查看blingHeart的类型：
type(of: blingHeart)

// Extended Grapheme Clusters
let eWithAcute = "é" //\u{E9}

// e + `
let anotherE = "\u{65}\u{301}"
//给 é 加上圆圈：
let eWithACircle = anotherE + "\u{20DD}"
//凡是这种把不同的Unicode变量值排列起来，形成单一Unicode字符的序列，就叫 `Extended Grapheme Clusters`


//: #### String operation 字符串操作
// Couting 读取字符串长度
let messageLength = message.characters.count
//另一个例子：
let cafe = "Caf" + anotherE
cafe.characters.count
//给 cafe 加圆圈：
let cafe1 = cafe + "\u{20DD}"
cafe1.characters.count  //长度仍旧是4
//结论：字符串长度是根据 `Extended Grapheme Clusters`长度确定的，而不是按照Unicode的标量值来确定的


//String indices   字符串中的单一字符
//cafe[0],cafe[1],cafe[2],cafe[3]
//应使用 Stirng.Index 来索引
cafe.startIndex
cafe.endIndex
cafe1.endIndex
//结论：在Swift里，直接使用整数值索引字符串是错误的

//访问当前位置的下一个字符：
cafe[cafe.index(after: cafe.startIndex)] //[cafe.startIndex.successor()]
//访问上一个字符：
cafe[cafe.index(before: cafe.endIndex)]  //cafe[cafe.endIndex.predecessor()]
//通过investOf  方法，来任意移动字符串中索引的位置：
cafe[cafe.index(cafe.startIndex, offsetBy: 3)]  //cafe[cafe.startIndex.advanceBy(3)]
//如果引用了字符串中不存在的位置，是会引发运行时错误的：
//cafe[cafe.index(after: cafe.endIndex)]  //发生错误



// Insert and remove 插入或删除字符串
//插入：
var cafe2 = cafe
cafe2.insert("!", at: cafe2.endIndex)
//用  方法，在字符串中插入另一个字符串：
//let abcd = Collection   "is delicious".characters
cafe2.insert(contentsOf: " is delicious".characters, at: cafe2.index(before: cafe2.endIndex))
//cafe2.insertContentsOf(" is delicious".characters, at: cafe2.endIndex.predecessor())

//删除指定字符：remove(at:)  :
cafe2.remove(at: cafe2.index(before: cafe2.endIndex))
cafe2
//removeSubrange  指定的字符串：
let range = cafe2.index(cafe2.endIndex, offsetBy: -13) ..< cafe2.endIndex
cafe2.removeSubrange(range)
cafe2


//String Equality 字符串是否相等
//说明：如果`Extended Grapheme Clusters`具有相同的语义，并且具有相同的外观，我们就认为这2个字符串是相等的。例如我们上面讲到的 eWithAcute 和 anotherE，尽管它们是由2个不同的Unicode标量构成的，但是由于最终它们形成的字符都会是`Latin Small Letter E with Acute`，因此我们认为 eWithAcute 和  anotherE是相等的。但是在Swift中，并不是所有相同外观的字符都是相等的：
let latinA = "\u{41}"
let cyrillicA = "\u{0410}"
if latinA != cyrillicA {
    print("They are not the same")
}


// hasPrefix and hasSuffix
//判断 字符串是否包含特定的前缀和后缀：
let boxue = "The best screencasts about iOS development"
boxue.hasPrefix("The best")
boxue.hasSuffix("iOS development")


// #### Unicode representation
//说明：当我们需要把一个Unicode字符存储在文本文件或者其他存储介质时，由于有些Unicode字符是可以以单个字节存储的，但是有些Unicode字符则是不能通过单个字符存储的，因此我们需要对Unicode字符进行一定形式的编码。这种编码方式就是我们都熟悉的UTF8、UTF16或者UTF32.
//所谓的UTF8，就是一组使用8位的数字序列来表达Unicode的标量值。在Swift中我们可以这样来访问字符的UTF8编码：
blingHeart.utf8
//使用for循环来读取utf8数组中的每一个数值：
for codeunit in blingHeart.utf8 {
    print("\(codeunit) ", terminator: "")
}

//看一种更复杂的swift Unicode使用，把codeunit转换成16进制的数：
for codeunit in blingHeart.utf16 {
    print("\(String(codeunit, radix:16)) ", terminator:"")
}

//UTF32编码又叫做 Unocode Scalar Representation
for codeunit in blingHeart.unicodeScalars {
    type(of: codeunit) // codeunit.dynamicType
    print("\(String(codeunit.value, radix:16)) ")
}





