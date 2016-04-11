//
//  main.swift
//  Tip15可变参数函数
//
//  Created by huangaengoln on 16/4/10.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")
//“可变参数函数指的是可以接受任意多个参数的函数，我们最熟悉的可能就是 NSString 的 -stringWithFormat: 方法了。在 Objective-C 中，我们使用这个方法生成字符串的写法是这样的：
/*
 NSString *name = @"Tom";
 NSDate *date = [NSDate date];
 NSString *string = [NSString stringWithFormat:@"Hello %@. Date: %@",name, date];
 */


//“这个方法中的参数是可以任意变化的，参数的第一项是需要格式化的字符串，后面的参数都是向第一个参数中填空。在这里我们不再详细描述 Objective-C 中可变参数函数的写法 (毕竟这是一本 Swift 的书)，但是我相信绝大多数即使有着几年 Objective-C 经验的读者，也很难在不查阅资料的前提下正确写出一个接受可变参数的函数。

//“但是这一切在 Swift 中得到了前所未有的简化。现在，写一个可变参数的函数只需要在声明参数时在类型后面加上 ... 就可以了。比如下面就声明了一个接受可变参数的 Int 累加函数：
#if false
    func sum(input: Int...) ->Int {
        //...
    }
#endif

//“输入的 input 在函数体内部将被作为数组 [Int] 来使用，让我们来完成上面的方法吧。当然你可以用传统的 for...in 做累加，但是这里我们选择了一种看起来更 Swift 的方式：
func sum(input: Int...) ->Int {
    return input.reduce(0, combine: +)
}
print(sum(1,2,3,4,5))
// 输出：15

//“Swift 的可变参数十分灵活，在其他很多语言中，因为编译器和语言自身语法特性的限制，在使用可变参数时往往可变参数只能作为方法中的最后一个参数来使用，而不能先声明一个可变参数，然后再声明其他参数。这是很容易理解的，因为编译器将不知道输入的参数应该从哪里截断。这个限制在 Swift 中是不存在的，因为我们会对方法的参数进行命名，所以我们可以随意地放置可变参数的位置，而不必拘泥于最后一个参数：
func myFunc(numbers:Int..., string: String) {
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i + 1): \(string)")
        }
    }
}
myFunc(1,2,3, string: "hello")
//输出：
//1: hello
//1: hello
//2: hello
//1: hello
//2: hello
//3: hello

//“限制自然是有的，比如在同一个方法中只能有一个参数是可变的，比如可变参数都必须是同一种类型的等。对于后一个限制，当我们想要同时传入多个类型的参数时就需要做一些变通。比如最开始提到的 -stringWithFormat: 方法。可变参数列表的第一个元素是等待格式化的字符串，在 Swift 中这会对应一个 String 类型，而剩下的参数应该可以是对应格式化标准的任意类型。一种解决方法是使用 Any 作为参数类型，然后对接收到的数组的首个元素进行特殊处理。不过因为 Swift 提供了使用下划线 _ 来作为参数的外部标签，来使调用时不再需要加上参数名字。我们可以利用这个特性，在声明方法是就指定第一个参数为一个字符串，然后跟一个匿名的参数列表，这样在写起来的时候就 "好像" 是所有参数都是在同一个参数列表中进行的处理，会好看很多。比如 Swift 的 NSString 格式化的声明就是这样处理的：
#if false
extension NSString {
    convenience init(format: NSString, _ args: CVarArgType...)
    //...
}
#endif

//“调用的时候就和在 Objective-C 时几乎一样了，非常方便：
let name = "Tom"
let date = NSDate()
let string = NSString(format: "Hello %@. Date:%@", name, date)


















