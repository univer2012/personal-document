import UIKit
import Foundation
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
    var a = Array(array)
    //选出随机的枢轴数字
    func randomPivot<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> T {
        let pivotIndex = Int(arc4random()) % (high - low) + low //随机数1
        //arc4random_uniform(UInt32(high - low)) + UInt32(low)  //随机数2
        //random(min: low, max: high)   //没有该函数
        print("pivotIndex:", pivotIndex)
        a.swapAt(Int(pivotIndex), high)
        return a[high]
    }
    
    func randomizedPartition<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> Int {
        let pivot = randomPivot(&a, low, high)
        var i = low
        for j in low ..< high {
            if a[j] <= pivot {
                a.swapAt(i, j)
                i += 1
                print("i = \(i), j = \(j), a = \(a)")
            }
        }
        
        a.swapAt(i, high)
        print("i = \(i), a = \(a)")
        return i
    }
    func randomizedSelect<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int, _ k: Int) -> T {
        if low < high {
            let p = randomizedPartition(&a, low, high)
            if k == p {
                return a[p]
            } else if k < p {
                return randomizedSelect(&a, low, p - 1, k)
            } else {
                return randomizedSelect(&a, p + 1, high, k)
            }
        } else {
            return a[low]
        }
    }
    precondition(a.count > 0)
    return randomizedSelect(&a, 0, a.count - 1, k)
}




var array = [ 7, 92, 23, 9, -1, 0, 11, 6 ]
//print(randomPivot(&array, 0, array.count - 1))        //可以运行
//print(randomizedPartition(&array, 0, array.count - 1))//可以运行
print(randomizedSelect(&array, 0, array.count - 1, 4))//可以运行


//print(randomizedSelect(array, order: 4))  //无法运行，报错：expression failed to parse, unknown error
