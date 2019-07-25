import UIKit

//var str = "Hello, playground"

/*
 来自：
 [二分搜索(Binary Search)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Binary%20Search)
 [Binary Search](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search)
 */

#if false
let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
print(numbers.firstIndex(of: 43))   // Optional(15)

//: 内置的indexOf()函数执行的是[线性搜索](https://github.com/andyRon/swift-algorithm-club-cn/blob/master/Linear%20Search)。代码大概是：

func linearSearch<T: Equatable>(_ a: [T], _ key: T) -> Int? {
    for i in 0 ..< a.count {
        if a[i] == key {
            return i
        }
    }
    return nil
}
//使用
print(linearSearch(numbers, 43))    // Optional(15)

#endif


#if false
//: ## 分而治之
func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        // If we get here, then the search key is not present in the array.
        return nil
        
    } else {
        // Calculate where to split the array.
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        // Is the search key in the left half?
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
        // Is the search key in the right half?
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
        // If we get here, then we've found the search key!
        } else {
            return midIndex
        }
        
    }
}
//测试
let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
let temp = binarySearch(numbers, key: 43, range: 0 ..< numbers.count) // Optional(13)
print(temp)
//: > 请注意，numbers数组已排序。 否则二分搜索算法不能工作！

#endif

/*:
 ## 迭代与递归
 这是Swift中二分搜索的迭代实现：
 */
func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else if a[midIndex] > key {
            upperBound = midIndex
        }
    }
    return nil
}
//测试
let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
print(binarySearch(numbers, key: 43))  // Optional(13)
