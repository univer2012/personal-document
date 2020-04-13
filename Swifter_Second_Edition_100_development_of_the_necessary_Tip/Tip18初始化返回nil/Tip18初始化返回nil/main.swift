//
//  main.swift
//  Tip18初始化返回nil
//
//  Created by huangaengoln on 16/4/10.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")

/*“在 Objective-C 中，init 方法除了返回 self 以外，其实和一个普通的实例方法并没有太大区别。如果你喜欢的话，甚至可以多次进行调用，这都没有限制。一般来说，我们还会在初始化失败 (比如输入不满足要求无法正确初始化) 的时候返回 nil 来通知调用者这次初始化没有正确完成。
 
 “但是，在 Swift 中默认情况下初始化方法是不能写 return 语句来返回值的，也就是说我们没有机会初始化一个 Optional 的值。一个很典型的例子就是初始化一个 url。在 Objective-C 中，如果我们使用一个错误的字符串来初始化一个 NSURL 对象时，返回会是 nil 代表初始化失败。所以下面这种 "防止度娘吞链接" 式的字符串 (注意两个 t 之间的空格和中文的句号) 的话，也是可以正常编译和运行的，只是结果是个 nil：
 */
/*
NSURL *url = [[NSURL alloc]initWithString:@"ht tp://swifter。tips"];
NSLog(@"%@", url);
//输出(null)
*/

//“但是在 Swift 中情况就不那么乐观了，-initWithString: 在 Swift 中对应的是一个 convenience init 方法：init(string URLString: String!)。上面的 Objective-C 代码在 Swift 中等效为：
let url1 = NSURL(string: "ht tp://swifter。tips")
print(url1)

//“init 方法在 Swift 1.1 中发生了很大的变化，为了将来龙去脉讲述清楚，我们先来看看在 Swift 1.0 下的表现。



//======================Swift 1.0 及之前
//“如果在 Swift 1.0 的环境下尝试运行上面代码的话，我们会得到一个 EXC_BAD_INSTRUCTION，这说明触发了 Swift 内部的断言，这个初始化方法不接受这样的输入。一个常见的解决方法是使用工厂模式，也就是写一个类方法来生成和返回实例，或者在失败的时候返回 nil。Swift 的 NSURL 就做了这样的处理：
//class func URLWithString(URLString: String!) ->Self!

//使用的时候:
//let url = NSURL.URLWithString("ht tp://swifter。tips")
//print(url)
//输出 nil




//“不过虽然可以用这种方式来和原来一样返回 nil，但是这也算是一种折衷。在可能的情况下，我们还是应该倾向于尽量减少出现 Optional 的可能性，这样更有助于代码的简化。
/*
 如果你确实想使用初始化方法而不愿意用工厂函数的话，也可以考虑用一个 Optional 量来存储结果
 
 这样你就可以处理初始化失败了，不过相应的代价是代码复杂度的增加
 */
let url2: NSURL? = NSURL(string: "ht tp://swifter。tips")
// nil




//==============“Swift 1.1 及之后
/*
 虽然在默认情况下不能在 init 中返回 nil，但是通过上面的例子我们可以看到 Apple 自家的 API 还是有这个能力的。
 
 “好消息是在 Swift 1.1 中 Apple 已经为我们加上了初始化方法中返回 nil 的能力。我们可以在 init 声明时在其后加上一个 ? 或者 ! 来表示初始化失败时可能返回 nil。比如为 Int 添加一个接收 String 作为参数的初始化方法。我们希望在方法中对中文和英文的数据进行解析，并输出 Int 结果。对其解析并初始化的时候，就可能遇到初始化失败的情况：
 */
extension Int {
    init?(fromString: String) {
        self = 0
        var digit = fromString.characters.count - 1
        for c in fromString.characters {
            var number = 0
            if let n = Int(String(c)) {
                number = n
            }
            else {
                switch c {
                case "一":
                    number = 1
                case "二":
                    number = 2
                case "三":
                    number = 3
                case "四":
                    number = 4
                case "五":
                    number = 5
                case "六":
                    number = 6
                case "七":
                    number = 7
                case "八":
                    number = 8
                case "九":
                    number = 9
                case "零":
                    number = 0
                default:
                    return nil
                }
            }
            
            self = self + number * Int(pow(10, Double(digit)))
            digit = digit - 1
        }
    }
}

let number1 = Int(fromString: "12");print(number1)
// {Some 12}

let number2 = Int(fromString: "三二五");print(number2)
// {Some 325}

let number3 = Int(fromString: "七9八");print(number3)
// {Some 798}

let number4 = Int(fromString: "吃了么");print(number4)
// nil

let number5 = Int(fromString: "la4n");print(number5)
// nil

//“所有的结果都将是 Int? 类型，通过 Optional Binding，我们就能知道初始化是否成功，并安全地使用它们了。我们在这类初始化方法中还可以对 self 进行赋值，也算是 init 方法里的特权之一。

//“同时像上面例子中的 NSURL.URLWithString 这样的工厂方法，在 Swift 1.1 中已经不再需要。为了简化 API 和安全，Apple 已经被标记为不可用了并无法编译。而对应地，可能返回 nil 的 init 方法都加上了 ? 标记：

//      convenience init?(string URLString: String)


//“在新版本的 Swift 中，对于可能初始化失败的情况，我们应该始终使用可返回 nil 的初始化方法，而不是类型工厂方法。




















