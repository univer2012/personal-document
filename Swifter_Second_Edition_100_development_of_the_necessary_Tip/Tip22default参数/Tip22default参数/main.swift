//
//  main.swift
//  Tip22default参数
//
//  Created by huangaengoln on 16/4/10.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")

/*
 “Swift 的方法是支持默认参数的，也就是说在声明方法时，可以给某个参数指定一个默认使用的值。在调用该方法时要是传入了这个参数，则使用传入的值，如果缺少这个输入参数，那么直接使用设定的默认值进行调用。可以说这是 Objective-C 社区盼了好多年的一个特性了，Objective-C 由于语法的特点几乎无法在不大幅改动的情况下很好地实现默认参数。
 
 “和其他很多语言的默认参数相比较，Swift 中的默认参数限制更少，并没有所谓 "默认参数之后不能再出现无默认值的参数"这样的规则，举个例子，下面两种方法的声明在 Swift 里都是合法可用的：
 */
func sayHello1(str1: String = "Hello", str2: String, str3: String) {
    print(str1 + str2 + str3)
}
func sayHello2(str1: String, str2: String, str3: String = "World") {
    print(str1 + str2 + str3)
}

//“其他不少语言只能使用后面一种写法，将默认参数作为方法的最后一个参数。

//在调用的时候，我们如果想要使用默认值的话，只要不传入相应的值就可以了。下面这样的调用将得到同样的结果：
sayHello1(str2: " ", str3: "World")
sayHello2("Hello", str2: " ")
//输出都是 "Hello World"

//“这两个调用都省略了带有默认值的参数，sayHello1 中 str1 是默认的 "Hello"，而 sayHello2 中的 str3 是默认的 "World"。

//另外如果喜欢 Cmd + 单击点来点去到处看的朋友可能会注意到 NSLocalizedString 这个常用方法的签名现在是：

//public func NSLocalizedString(key: String, tableName: String? = default, bundle: NSBundle = default, value: String = default, comment: String) -> String



//“默认参数写的是 default，这是含有默认参数的方法所生成的 Swift 的调用接口。当我们指定一个编译时就能确定的常量来作为默认参数的取值时，这个取值是隐藏在方法实现内部，而不应该暴露给其他部分。与 NSLocalizedString 很相似的还有 Swift 中的各类断言：
//public func assert(@autoclosure condition: () -> Bool, @autoclosure _ message: () -> String = default, file: StaticString = #file, line: UInt = #line)




















