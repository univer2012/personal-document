//
//  main.swift
//  Tip31-lazy修饰符和lazy方法
//
//  Created by huangaengoln on 16/4/11.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")
/*
 “延时加载或者说延时初始化是很常用的优化方法，在构建和生成新的对象的时候，内存分配会在运行时耗费不少时间，如果有一些对象的属性和内容非常复杂的话，这个时间更是不可忽略。另外，有些情况下我们并不会立即用到一个对象的所有属性，而默认情况下初始化时，那些在特定环境下不被使用的存储属性，也一样要被初始化和赋值，也是一种浪费。
 
 “在其他语言 (包括 Objective-C) 中延时加载的情况是很常见的。我们在第一次访问某个属性时，判断这个属性背后的存储是否已经存在，如果存在则直接返回，如果不存在则说明是首次访问，那么就进行初始化并存储后再返回。这样我们可以把这个属性的初始化时刻推迟，与包含它的对象的初始化时刻分开，以达到提升性能的目的。以 Objective-C 举个例子 (虽然这里既没有费时操作，也不会因为使用延时加载而造成什么性能影响，但是作为一个最简单的例子，可以很好地说明问题)：
 */
/*
//ClassA.h
@property(nonatomic, copy)NSString *testString;

//ClassA.m
-(NSString *)testString {
    if (!_testString) {
        _testString = @"Hello";
        NSLog(@"只在首次访问输出");
    }
    return _testString;
}
*/

//“在初始化 ClassA 对象后，_testString 是 nil。只有当首次访问 testString 属性时 getter 方法会被调用，并检查如果还没有初始化的话，就进行赋值。为了方便确认，我们还在赋值时打印了一句 log。我们之后再多次访问这个属性的话，因为 _testString 已经有值，因此将直接返回。



//“在 Swift 中我们使用在变量属性前加 lazy 关键字的方式来简单地指定延时加载。比如上面的的代码我们在 Swift 中重写的话，会是这样：
class ClassA {
    lazy var str: String = {
        let str = "Hello"
        print("只在首次访问输出")
        return str
    }()
}
//“我们在使用 lazy 作为属性修饰符时，只能声明属性是变量。另外我们需要显式地指定属性类型，并使用一个可以对这个属性进行赋值的语句来在首次访问属性时运行。如果我们多次访问这个实例的 str 属性的话，可以看到只有一次输出。

//“为了简化，我们如果不需要做什么额外工作的话，也可以对这个 lazy 的属性直接写赋值语句：
class ClassA1 {
    lazy var str: String = "Hello"
}
//“相比起在 Objective-C 中的实现方法，现在的 lazy 使用起来要方便得多。


//“另外一个不太引起注意的是，在 Swift 的标准库中，我们还有一组 lazy 方法，它们的定义是这样的：
#if false
    func lazy<S : SequenceType>(s: S) -> LazySequence<S>
    
    func lazy<S : CollectionType where S.Index : RandomAccessIndexType>(s: S)
        -> LazyRandomAccessCollection<S>
    
    func lazy<S : CollectionType where S.Index : BidirectionalIndexType>(s: S)
        -> LazyBidirectionalCollection<S>
    
    func lazy<S : CollectionType where S.Index : ForwardIndexType>(s: S)
        -> LazyForwardCollection<S>
#endif
//“这些方法可以配合像 map 或是 filter 这类接受闭包并进行运行的方法一起，让整个行为变成延时进行的。在某些情况下这么做也对性能会有不小的帮助。例如，直接使用 map 时：
let data = 1...3
let result = data.map {
    (i: Int) ->Int in
    print("正在处理\(i)")
    return i * 2
}

print("准备访问结果")
for i in result {
    print("操作后结果为\(i)")
}
print("操作完毕")
//这么做的输出为：
//正在处理1
//正在处理2
//正在处理3
//准备访问结果
//操作后结果为2
//操作后结果为4
//操作后结果为6
//操作完毕


//“而如果我们先进行一次 lazy 操作的话，我们就能得到延时运行版本的容器：
let data1 = 1...3
let result1 = data1.lazy.map {
    (i: Int) ->Int in
    print("正在处理\(i)")
    return i * 2
}
print("准备访问结果")
for i in result1 {
    print("操作后结果为\(i)")
}
print("操作完毕")
//“此时的运行结果：
//准备访问结果
//正在处理1
//操作后结果为2
//正在处理2
//操作后结果为4
//正在处理3
//操作后结果为6
//操作完毕

//“对于那些不需要完全运行，可能提前退出的情况，使用 lazy 来进行性能优化效果会非常有效。











