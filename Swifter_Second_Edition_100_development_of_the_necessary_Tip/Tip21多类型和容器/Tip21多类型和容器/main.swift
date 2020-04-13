//
//  main.swift
//  Tip21多类型和容器
//
//  Created by huangaengoln on 16/4/10.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")
// “Swift 中常用的原生容器类型有三种，它们分别是 Array、Dictionay 和 Set：
#if false
struct Array<Element>:CollectionType, Indexable, SequenceType, MutableCollectionType, _DestructorSafeContainer {
    //...
}
    
struct Dictionary<Key: Hashable, Value>:CollectionType, Indexable, SequenceType, DictionaryLiteralConvertible {
    //...
}
    
public struct Set<Element: Hashable>:Hashable, Equatable, CollectionType, Indexable, SequenceType, ArrayLiteralConvertible {
    //...
}
#endif

//“它们都是泛型的，也就是说我们在一个集合中只能放同一个类型的元素。比如：
let numbers = [1, 2, 3, 4, 5]
// numbers 的类型是 [Int]

let strings = ["hello", "world"]
//strings 的类型是 [String]

//“如果我们要把不相关的类型放到同一个容器类型中的话，一个比较容易想到的是使用 Any 或者 AnyObject，或者是使用 NSArray：
let mixed: [Any] = [1, "two", 3]

//如果不指名类型，由于UIKit的存在
// 将被推断为 [NSObject]
let objectArray = [1, "two", 3]

//“这样的转换会造成部分信息的损失，我们从容器中取值时只能得到信息完全丢失后的结果，在使用时还需要进行一次类型转换。这其实是在无其他可选方案后的最差选择：因为使用这样的转换的话，编译器就不能再给我们提供警告信息了。我们可以随意地将任意对象添加进容器，也可以将容器中取出的值转换为任意类型，这是一件十分危险的事情：
let any = mixed[0]  //Any类型
let nsObject = objectArray[0]   //NSObject类型


//“其实我们注意到，Any 其实是 protocol，而不是具体的某个类型。因此就是说其实在容器类型泛型的帮助下，我们不仅可以在容器中添加同一具体类型的对象，也可以添加实现了同一接口的类型的对象。绝大多数情况下，我们想要放入一个容器中的元素或多或少会有某些共同点，这就使得用接口来规定容器类型会很有用。比如上面的例子如果我们希望的是打印出容器内的元素的 description，可能我们更倾向于将数组声明为 [CustomStringConvertible] 的：
let mixed1: [CustomStringConvertible] = [1, "two", 3]
for obj in mixed1 {
    print(obj.description)
}

//“这种方法虽然也损失了一部分类型信息，但是相对于 Any 或者 AnyObject 还是改善很多，在对于对象中存在某种共同特性的情况下无疑是最方便的。另一种做法是使用 enum 可以带有值的特点，将类型信息封装到特定的 enum 中。下面的代码封装了 Int 或者 String 类型：
enum IntOrString {
    case IntValue(Int)
    case StringValue(String)
}
let mixed2 = [IntOrString.IntValue(1),
IntOrString.StringValue("two"),
IntOrString.IntValue(3)]

for value in mixed2 {
    switch value {
    case let .IntValue(i):
        print(i * 2)
    case let .StringValue(s):
        print(s.capitalizedString)
    }
}
//输出
//2
//Two
//6
//“通过这种方法，我们完整地在编译时保留了不同类型的信息。为了方便，我们甚至可以进一步为 IntOrString 使用字面量转换的方法编写简单的获取方式，但那是另外一个故事了。



















