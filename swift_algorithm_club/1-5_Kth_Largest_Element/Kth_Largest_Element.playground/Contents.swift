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
    
    //var temp = 0 //测试代码
    /*第一次取下标为6的数字11，结果为[7,   9,  -1, 0, 6, 11x, 23x, 92x]
     第二次取下标为4的数字6，  结果为[-1x, 0x, 6x, 9, 7, 11x, 23x, 92x]
     第二次取下标为3的数字9，  结果为[-1x, 0x, 6x, 7, 9, 11x, 23x, 92x]
     */
    //let indexArray = [6, 4, 3] //测试代码
    //选出随机的枢轴数字
    func randomPivot<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> T {
        
        /*
         测试代码：
         let pivotIndex = indexArray[temp]
         temp += 1*/
        let pivotIndex = Int(arc4random()) % (high - low) + low // 随机数1
        //Int(arc4random_uniform(UInt32(high - low))) + low // 随机数2
        //random(min: low, max: high)  //没有这个函数
        print("pivotIndex:", pivotIndex)
        print("swapAt_before:", a)
        a.swapAt(pivotIndex, high)
        print("swapAt_after: ", a)
        return a[high]
    }
    
    func randomizedPartition<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> Int {
        let pivot = randomPivot(&a, low, high)
        print("pivot:", pivot)
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
            print("low = \(low), high = \(high), k = \(k), p = \(p)")
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

let array = [ 7, 92, 23, 9, -1, 0, 11, 6 ]
print(randomizedSelect(array, order: 4))
