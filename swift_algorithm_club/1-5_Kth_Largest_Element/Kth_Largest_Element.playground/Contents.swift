import UIKit

//var str = "Hello, playground"

/*
 来自：
 1. [第K大元素问题(k-th Largest Element Problem)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Kth%20Largest%20Element)
 2. [k-th Largest Element Problem](https://github.com/andyRon/swift-algorithm-club/tree/master/Kth%20Largest%20Element)
 */

/*:
 ## 朴素的解决方案
 以下解决方案是半朴素的。 它的**时间复杂度是 O(nlogn)**，因为它首先对数组进行排序，因此也使用额外的 O(n) 空间。
 */

//返回第K大元素
func kthLargest(a: [Int], k: Int) -> Int? {
    let len = a.count
    if k > 0 && k <= len {
        let sorted = a.sorted() // 从小到大 排序
        return sorted[len - k]
        //return sorted[k - 1] //第k个最小的元素
    } else {
        return nil
    }
}

/*:
 ## 更快的解决方案
 有一种聪明的算法结合了*二元搜索和快速排序的思想*来达到**O(n)**解决方案。
 */

public func randomizedSelect<T: Comparable>(_ array: [T], order k: Int) -> T {
    var a = array
    
    func randomPivot<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> T {
        let pivotIndex =  random(min: low, max: high)
        a.swapAt(pivotIndex, high)
        return a[high]
    }
    
    func randomizedPartition<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> Int {
        let pivot = randomPivot(&a, low, high)
        var i = low
        for j in low ..< high {
            if a[j] <= pivot {
                a.swapAt(i, j)
                i += 1
            }
        }
        a.swapAt(i, high)
        return i
    }
}

