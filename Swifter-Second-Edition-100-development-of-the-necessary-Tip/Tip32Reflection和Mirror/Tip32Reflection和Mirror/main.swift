//
//  main.swift
//  Tip32Reflection和Mirror
//
//  Created by huangaengoln on 16/4/11.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")
/*
 “熟悉 Java 的读者可能会知道反射 (Reflection)。这是一种在运行时检测、访问或者修改类型的行为的特性。一般的静态语言类型的结构和方法的调用等都需要在编译时决定，开发者能做的很多时候只是使用控制流 (比如 if 或者 switch) 来决定做出怎样的设置或是调用哪个方法。而反射特性可以让我们有机会在运行的时候通过某些条件实时地决定调用的方法，或者甚至向某个类型动态地设置甚至加入属性及方法，是一种非常灵活和强大的语言特性。
 
 “Objective-C 中我们不太会经常提及到 “反射” 这样的词语，因为 Objective-C 的运行时比一般的反射还要灵活和强大。可能很多读者已经习以为常的像是通过字符串生成类或者 selector，并且进而生成对象或者调用方法等，其实都是反射的具体的表现。而在 Swift 中其实就算抛开 Objective-C 的运行时的部分，在纯 Swift 范畴内也存在有反射相关的一些内容，只不过相对来说功能要弱得多。
 
 “因为这部分内容并没有公开的文档说明，所以随时可能发生变动，或者甚至存在今后被从 Swift 的可调用标准库中去掉的可能 (Apple 已经干过这种事情，最早的时候 Swift 中甚至有隐式的类型转换 __conversion，但因为太过危险，而被彻底去除了。现在隐式转换必须使用字面量转换的方式进行了)。在实际的项目中，也不建议使用这种没有文档说明的 API，不过有时候如果能稍微知道 Swift 中也存在这样的可能性的话，也许会有帮助 (也指不定哪天 Apple 就扔出一个完整版的反射功能呢)。
 
 “Swift 中所有的类型都实现了 _Reflectable，这是一个内部接口，我们可以通过 _reflect 来获取任意对象的一个镜像，这个镜像对象包含类型的基本信息，在 Swift 2.0 之前，这是对某个类型的对象进行探索的一种方法。在 Swift 2.0 中，这些方法已经从公开的标准库中移除了，取而代之，我们可以使用 Mirror 来
 */
struct Person {
    let name: String
    let age: Int
}
let xiaoMing = Person(name: "XiaoMing", age: 16)
let r = Mirror(reflecting: xiaoMing)    //r是MirrorType
print("xiaoMing是\(r.displayStyle)");
print("属性个数:\(r.children.count)");
for i in r.children.startIndex..<r.children.endIndex {
    print("属性名:\(r.children[i].0!),值:\(r.children[i].1)");
}
//输出：
//xiaoMing是Optional(Swift.Mirror.DisplayStyle.Struct)
//属性个数:2
//属性名:name,值:XiaoMing
//属性名:age,值:16

//“通过 Mirror 初始化得到的结果中包含的元素的描述都被集合在 children 属性下，如果你有心可以到 Swift 标准库中查找它的定义，它实际上是一个 Child 的集合，而 Child 则是一对键值的多元组：
#if false
public typealias Child = (label: String?, value: Any)

public typealias Children = AnyForwardCollection<Child>
#endif

//“AnyForwardCollection 是遵守 CollectionType 接口的，因此我们可以简单地使用 count 来获取元素的个数，而对于具体的代表属性的多元组，则使用下标进行访问。在对于我们的例子中，每个 Child 都是具有两个元素的多元组，其中第一个是属性名，第二个是这个属性所存储的值。需要特别注意的是，这个值有可能是多个元素组成嵌套的形式 (例如属性值是数组或者字典的话，就是这样的形式)。

//“如果觉得一个个打印太过于麻烦，我们也可以简单地使用 dump 方法来通过获取一个对象的镜像并进行标准输出的方式将其输出出来。比如对上面的对象 xiaoMing：
dump(xiaoMing)
//输出：
//▿ Tip32Reflection和Mirror.Person
//- name: XiaoMing
//- age: 16


/*“在这里因为篇幅有限，而且这部分内容很可能随着版本而改变，我们就不再一一介绍 Mirror 的更详细的内容了。有兴趣的读者不妨打开 Swift 的定义文件并找到这个接口，里面对每个属性和方法的作用有非常详细的注释。
 
 “对于一个从对象反射出来的 Mirror，它所包含的信息是完备的。也就是说我们可以在运行时通过 Mirror 的手段了解一个 Swift 类型 (当然 NSObject 类也可以) 的实例的属性信息。该特性最容易想到的应用的特性就是为任意 model 对象生成对应的 JSON 描述。我们可以对等待处理的对象的 Mirror 值进行深度优先的访问，并按照属性的 valueType 将它们归类对应到不同的格式化中。
 
 “另一个常见的应用场景是类似对 Swift 类型的对象做像 Objective-C 中 KVC 那样的 valueForKey: 的取值。通过比较取到的属性的名字和我们想要取得的 key 值就行了，非常简单：
 */
func valueFrom(object: Any, key: String) ->Any? {
    let mirror = Mirror(reflecting: object)
    for i in mirror.children.startIndex..<mirror.children.endIndex {
        let (targetKey, targetMirror) = mirror.children[i]
        if key == targetKey {
            return targetMirror
        }
    }
    return nil
}
//接上面的 xiaoMing
if let name = valueFrom(xiaoMing, key: "name") as? String {
    print("通过key得到值：\(name)")
}
//输出：
// 通过key得到值：XiaoMing

//“在现在的版本中，Swift 的反射特性并不是非常强大，我们只能对属性进行读取，还不能对其设定，不过我们有希望能在将来的版本中获得更为强大的反射特性。另外需要特别注意的是，虽然理论上将反射特性应用在实际的 app 制作中是可行的，但是这一套机制设计的最初目的是用于 REPL 环境和 Playground 中进行输出的。所以我们最好遵守 Apple 的这一设定，只在 REPL 和 Playground 中用它来对一个对象进行深层次的探索，而避免将它用在 app 制作中 -- 因为你永远不知道什么时候它们就会失效或者被大幅改动。
























