import UIKit
/*
 来自：
 1. [统计出现次数(Count Occurrences)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Count%20Occurrences)
 2. [Count Occurrences](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Count%20Occurrences)*/
//var str = "Hello, playground"
//条件：数组已经排过序的！！！
func countOccurrencesOf(key: Int, inArray a: [Int]) -> Int {
    func leftBoundary() -> Int {
        var low = 0
        var high = a.count
        while low < high {
            let midIndex = low + (high - low) / 2
            if a[midIndex] < key {
                low = midIndex + 1
            } else {
                high = midIndex
            }
        }
        return low
    }
    
    func rightBoundary() -> Int {
        var low = 0
        var high = a.count
        while low < high {
            let midIndex = low + (high - low) / 2
            if a[midIndex] > key {
                high = midIndex
            } else {
                low = midIndex + 1
            }
        }
        return low
    }
    return rightBoundary() - leftBoundary()
}

//测试
let a = [ 0, 1, 1, 3, 3, 3, 3, 6, 8, 10, 11, 11 ]
countOccurrencesOf(key: 3, inArray: a) // 4


