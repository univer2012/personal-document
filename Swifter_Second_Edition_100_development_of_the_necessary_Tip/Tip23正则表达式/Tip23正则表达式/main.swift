//
//  main.swift
//  Tip23正则表达式
//
//  Created by huangaengoln on 16/4/11.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")
/*
 “作为一门先进的编程语言，Swift 可以说吸收了众多其他先进语言的优点，但是有一点却是让人略微失望的，就是 Swift 至今为止并没有在语言层面上支持正则表达式。
 
 大概是因为其实 app 开发并不像 Perl 或者 Ruby 那样的语言需要处理很多文字匹配的问题，Cocoa 开发者确实不是特别依赖正则表达式。但是并不排除有希望使用正则表达式的场景，我们是否能像其他语言一样，使用比如 =~ 这样的符号来进行正则匹配呢？
 
 “最容易想到也是最容易实现的当然是自定义 =~ 这个运算符。在 Cocoa 中我们可以使用 NSRegularExpression 来做正则匹配，那么其实我们为它写一个包装也并不是什么太困难的事情。因为做的是字符串正则匹配，所以 =~ 左右两边都是字符串。我们可以先写一个接受正则表达式的字符串，以此生成 NSRegularExpression 对象。然后使用该对象来匹配输入字符串，并返回结果告诉调用者匹配是否成功。一个最简单的实现可能是下面这样的：
 */
struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
    }
    
    func match(input: String) -> Bool {
        let matches = regex.matchesInString(input, options: [], range: NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}

//“在使用的时候，比如我们想要匹配一个邮箱地址，我们可以这样来使用：
let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
let matcher: RegexHelper
do {
    matcher = try RegexHelper(mailPattern)
}
let maybeMailAddress = "onev@onvecat.com"

if matcher.match(maybeMailAddress) {
    print("有效的邮箱地址")
}
//输出
// 有效的邮箱地址

/*
 “如果你想问 mailPattern 这一大串莫名其妙的匹配表达式是什么意思的话..>嘛..实在抱歉这里不是正则表达式的课堂，所以关于这个问题我>推荐看看这篇很棒的(正则表达式 30 分钟入门教程)[http://deerchao.net/tutorials/regex/regex.htm]，如果你连 30 分钟都没有的话，打开 (8 个常用正则表达式)[http://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149] 先开始抄吧..
 
 上面那个式子就是我从这里抄来的
 */
//“现在我们有了方便的封装，接下来就让我们实现 =~ 吧。这里只给出结果了，关于如何实现操作符和重载操作符的内容，可以参考操作符一节的内容。
infix operator =~ {
    associativity none
    precedence 130
}

func =~(lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(lhs)
    } catch _ {
        return false
    }
}

//“这下我们就可以使用类似于其他语言的正则匹配的方法了：
if "onec@onevcat.com" =~ "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" {
    print("有效的邮箱地址")
}
//输出 
// 有效的邮箱地址

//“Swift 1.0 版本主要会专注于成为一个非常适合制作 app 的语言，而现在看来 Apple 和 Chris 也有野心将 Swift 带到更广阔的平台去。那时候可能会在语言层面加上正则表达式的支持，到时候这篇 tip 可能也就没有意义了，不过我个人还是非常期盼那一天早些到来。















