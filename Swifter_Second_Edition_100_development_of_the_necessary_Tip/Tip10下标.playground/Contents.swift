//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//“下标相信大家都很熟悉了，在绝大多数语言中使用下标来读写类似数组或者是字典这样的数据结构的做法，似乎已经是业界标准。在 Swift 中，Array 和 Dictionary 当然也实现了下标读写：
var arr = [1, 2, 3]
arr[2]
arr[2] = 4;
print(arr)

var dic = ["cat":"meow", "goat":"mie"]
dic["cat"]
dic["cat"] = "miao"
print(dic)

//“数组的话没有什么好多说的，但是字典需要注意，我们通过下标访问得到的结果是一个 Optional 的值。这是很容易理解的，因为你不能限制下标访问时的输入值，对于数组来说如果越界了只好直接给你脸色让你崩掉，但是对于字典，查询不到是很正常的一件事情。对此，在 Swift 中我们有更好的处理方式，那就是返回 nil 告诉你没有要找的东西。

//“作为一门代表了先进生产力的语言，Swift 是允许我们自定义下标的。这不仅包含了对自己写的类型进行下标自定义，也包括了对那些已经支持下标访问的类型 (没错就是 Array 和 Dictionay) 进行扩展。我们重点来看看向已有类型添加下标访问的情况吧，比如说 Array。很容易就可以在 Swift 的定义文件 (在 Xcode 中通过 Cmd + 单击任意一个 Swift 内建的类型或者函数就可以访问到) 里，找到 Array 已经支持的下标访问类型：
#if false
//subscript (index: Int) ->T
//subscript (subRange: Range<Int>) -> Slice<T>
#endif

//“共有两种，它们分别接受单个 Int 类型的序号和一个表明范围的 Range<Int>，作为对应，返回值也分别是单个元素和一组对应输入返回的元素。




//于是我们发现一个挺郁闷的问题，那就是我们很难一次性取出某几个特定位置的元素，比如在一个数组内，我想取出 index 为 0, 2, 3 的元素的时候，现有的体系就会比较吃力。我们很可能会要去枚举数组，然后在循环里判断是否是我们想要的位置。其实这里有更好的做法，比如说可以实现一个接受数组作为下标输入的读取方法：

extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        
        set {
            for (index, i) in input.enumerate() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

// “这样，我们的 Array 的灵活性就大大增强了:
var arr1 = [1, 2, 3, 4, 5]
arr1[[0, 2, 3]]
arr1[[0, 2, 3]] = [-1, -2, -3]







