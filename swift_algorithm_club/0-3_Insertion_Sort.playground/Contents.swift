import UIKit

//var str = "Hello, playground"

/*
 来自：[插入排序(Insertion Sort)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Insertion%20Sort)
 [Insertion Sort](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Insertion%20Sort)
 */
#if false
func insertionSort(_ array: [Int]) -> [Int] {
    var a = array                           // 1
    for x in 1 ..< a.count {                // 2
        var y = x
        while y > 0 && a[y] < a[y - 1] {    // 3
            a.swapAt(y - 1, y)
            y -= 1
        }
        
    }
    return a
}
/*:
 代码工作原理：
 
 1. 先创建一个数组的拷贝。因为我们不能直接修改参数`array`中的内容，所以这是非常必要的。`insertionSort()` 会返回一个原始数组的拷贝，就像`Swift`已拥有的`sort()` 方法一样。
 
 2. 在函数里有两个循环，外循环依次查找数组中的每一个元素；这就是从数字堆中取最上面的数字的过程。变量x是有序部分结束和堆开始的索引（也就是 | 符号的位置）。要记住的是，在任何时候，从0到x的位置数组都是有序的，剩下的则是无序的。
 
 3. 内循环则从 `x` 位置的元素开始查找。`x`是堆顶的元素，它有可能比前面的所有元素都小。内循环从有序数组的后面开始往前查找。每次找到一个大的元素，就交换它们的位置，直到内层循环结束，数组的前面部分依然是有序的，有序的元素也增加了一个。
 
 > 注意： 外层循环是从1开始，而不是0。从堆顶将第一个元素移动到有序数组没有任何意义，可以跳过。
*/
//测试
let list = [10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26]
print(insertionSort(list))
#endif

#if false
//: ## 不交换

func insertionSort(_ array: [Int]) -> [Int] {
    var a = array
    for x in 1 ..< a.count {
        var y = x
        let temp = a[y]
        while y > 0 && temp < a[y - 1] {
            a[y] = a[y - 1]         // 1
            y -= 1
        }
        a[y] = temp                 // 2
    }
    return a
}
/*:
 * `//1` 这行代码就是将前一个元素往右移动一个位置，在内层循环结束的时候， y 就是 插入的数字 在有序数组中的位置，
 * `//2` 这行代码就是将数字拷贝到正确的位置。
 */
#endif

//: ## 泛型化
func insertionSort<T>(_ array: [T],_ isOrderedBefore: (T, T) -> Bool) -> [T] {
    var a = array
    for x in 1 ..< a.count {
        var y = x
        let temp = a[y]
        while y > 0 && isOrderedBefore(temp, a[y - 1]) {
            a[y] = a[y - 1]         // 1
            y -= 1
        }
        a[y] = temp                 // 2
    }
    return a
}

//测试1
let numbers = [10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26]
print(insertionSort(numbers, <))    // [-1, 0, 1, 2, 3, 3, 5, 8, 9, 10, 26, 27]
print(insertionSort(numbers, >))    // [27, 26, 10, 9, 8, 5, 3, 3, 2, 1, 0, -1]
/*:
 `<` 和 `>` 决定排序的顺序，分别代表低到高和高到低。
 
 > 译注：参数`isOrderedBefore`可以使用`<`或`>`，是因为在`Swift`中运算符定义就类似`(T, T) -> Bool`。
 > 在`Foundation`中可以看到不同类型定义了运算符，比如`Decimal`就定义了<： `public static func < (lhs: Decimal, rhs: Decimal) -> Bool`。
 > `Swift`文档介绍了[Custom Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html#ID42)可以参考。
 */
//测试2
let strings = ["b", "a", "d", "c", "e"]
print(insertionSort(strings, <))    // ["a", "b", "c", "d", "e"]

/*: ## 性能
 插入排序的最差和平均性能是 O(n^2)。这是因为在函数里有两个嵌套的循环。其他如快速排序和归并排序的性能则是 O(n log n)，在有大量输入的时候会更快。
 */

