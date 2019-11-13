//
//  main.swift
//  Tip24模式匹配
//
//  Created by huangaengoln on 16/4/11.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")
//“在之前的正则表达式中，我们实现了 =~ 操作符来完成简单的正则匹配。虽然在 Swift 中没有内置的正则表达式支持，但是一个和正则匹配有些相似的特性其实是内置于 Swift 中的，那就是(模式匹配)。

//“当然，从概念上来说正则匹配只是模式匹配的一个子集，但是在 Swift 里现在的模式匹配还很初级，也很简单，只能支持最简单的相等匹配和范围匹配。在 Swift 中，使用 ~= 来表示模式匹配的操作符。如果我们看看 API 的话，可以看到这个操作符有下面几种版本：
#if false
func ~=<T : Equatable>(a: T, b: T) -> Bool

func ~=<T>(lhs: _OptionalNilComparisonType, rhs: T?) -> Bool

func ~=<I : IntervalType>(pattern: I, value: I.Bound) -> Bool
#endif

//“从上至下在操作符左右两边分别接收可以判等的类型，可以与 nil 比较的类型，以及一个范围输入和某个特定值，返回值很明了，都是是否匹配成功的 Bool 值。你是否有想起些什么呢..没错，就是 Swift 中非常强大的 switch，我们来看看 switch 的几种常见用法吧：
//1.可以判等的类型的判断
let password = "akfuv(3"
switch password {
    case "akfuv(3": print("密码通过")
    default : print("验证失败")
}

//2.对Optional的判断
let num: Int? = nil
switch num {
case nil: print("没值")
default: print("\(num!)")
}

//3.对范围的判断
let x = 0.5
switch x {
case -1.0...1.0: print("区间内")
default: print("区间外")
}

//“这并不是巧合。没错，Swift 的 switch 就是使用了 ~= 操作符进行模式匹配，case 指定的模式作为左参数输入，而等待匹配的被 switch 的元素作为操作符的右侧参数。只不过这个调用是由 Swift 隐式地完成的。于是我们可以发挥想象的地方就很多了，比如在 switch 中做 case 判断的时候，我们完全可以使用我们自定义的模式匹配方法来进行判断，有时候这会让代码变得非常简洁，具有条理。我们只需要按照需求重载 ~= 操作符就行了，接下来我们通过一个使用正则表达式做匹配的例子加以说明。

// “首先我们要做的是重载 ~= 操作符，让它接受一个 NSRegularExpression 作为模式，去匹配输入的 String：
func ~= (pattern: NSRegularExpression, input: String) ->Bool {
    return pattern.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) > 0
}

//“然后为了简便起见，我们再添加一个将字符串转换为 NSRegularExpression 的操作符 (当然也可以使用 StringLiteralConvertible，但是它不是这个 tip 的主题，在此就先不使用它了)：
prefix operator ~/
prefix func ~/ (pattern: String) ->NSRegularExpression {
    return try! NSRegularExpression(pattern: pattern, options: [])
//    return NSRegularExpression(pattern: pattern, options: nil, error: nil)
}

//“现在，我们在 case 语句里使用正则表达式的话，就可以去匹配被 switch 的字符串了：
let contact = ("http://onevcat.com", "onev@onevcat.com")
let mailRegex: NSRegularExpression
let siteRegex: NSRegularExpression

mailRegex =
    try ~/"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
siteRegex =
    try ~/"^(https?:\\/\\/)?([da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w\\.-]*)*\\/?$"
switch contact {
case (siteRegex, mailRegex): print("同时拥有有效的网站和邮箱")
case (_, mailRegex): print("只拥有有效的邮箱")
case (siteRegex, _): print("只拥有有效的网站")
default: print("嘛都没有")
}
//输出
//


























