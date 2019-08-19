import UIKit

//var str = "Hello, playground"

/*:
 
 来自：[快速排序(Quicksort)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Quicksort)
 
 [Quicksort](https://github.com/andyRon/swift-algorithm-club/tree/master/Quicksort)
 */


func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else {
        return a
    }
    
    let pivot = a[a.count / 2]
    let less = a.filter{ $0 < pivot }
    let equal = a.filter{ $0 == pivot }
    let greater = a.filter{ $0 > pivot }
    
    return quicksort(less) + equal + quicksort(greater)
}
//: > 译注：pivot 中心点，枢轴，基准。本文的pivot都翻译成“基准”。

let list = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
print( quicksort(list) ) // [-1, 0, 1, 2, 3, 5, 8, 8, 9, 10, 14, 26, 27]



/*:
 唯一可以保证的是在基准元素左边是所有较小的元素，而右边是所有较大的元素。 因为分区改变相等元素的原始顺序，所以快速排序不会产生“稳定”排序（与[归并排序](https://github.com/andyRon/swift-algorithm-club-cn/blob/master/Merge%20Sort)不同）。 这大部分时间都不是什么大不了的事。
 */


/*:
 ## Lomuto的分区方案
 在快速排序的第一个例子中，我告诉你，分区是通过调用Swift的`filter()`函数三次来完成的。 这不是很高效。 因此，让我们看一个更智能的分区算法，它可以 in place，即通过修改原始数组。
 */
func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    //print("pivot = \(pivot)")
    var i = low
    for j in low ..< high {
        if a[j] <= pivot {
            //print("before: a[i] = a[\(i)] = \(a[i]), a[j] = a[\(j)] = \(a[j])")
            (a[i], a[j]) = (a[j], a[i])   // 值的位置互换
            //print("after: a[i] = a[\(i)] = \(a[i]), a[j] = a[\(j)] = \(a[j])")
            i += 1
            //print("a = \(a)")  //查看a的变化请打开注释
        }
    }
    
    (a[i], a[high]) = (a[high], a[i])
    return i
}
//测试
//var list1 = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
//let p = partitionLomuto(&list1, low: 0, high: list.count - 1)
//print("list1 = \(list1)")


//: ## 使用Lomuto分区方案来构建快速排序
func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: p - 1)
        quicksortLomuto(&a, low: p + 1, high: high)
    }
}

//测试
var list2 = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
quicksortLomuto(&list2, low: 0, high: list2.count - 1)
print("list2 = \(list2)")


/*:
 Lomuto方案不是唯一的分区方案，但它可能是最容易理解的。 它不如Hoare的方案有效，后者需要的交换操作更少。
 
 ## Hoare的分区方案
 **这种分区方案是由快速排序的发明者Hoare完成的。**
 */

func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1
    print("origin: i = \(i), j = \(j)")
    while true {
        repeat { j -= 1 } while a[j] > pivot
        repeat { i += 1 } while a[i] < pivot
        print("i = \(i), j = \(j)")
        if i < j {
            a.swapAt(i, j)
            print("a = \(a)")
        } else {
            return j
        }
    }
}

//测试
var list3 = [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 ]
let p = partitionHoare(&list3, low: 0, high: list3.count - 1)
print("p = \(p), list3 = \(list3)")
//打印： p = 6, list3 = [-1, 0, 3, 8, 2, 5, 1, 27, 10, 14, 9, 8, 26]

/*:
 请注意，这次基准根本不在中间。 与Lomuto的方案不同，返回值不一定是新数组中基准元素的索引。
 
 结果，数组被划分为区域`[low ... p]`和`[p + 1 ... high]`。 这里，返回值`p`是`6`，因此两个分区是`[-1,0,3,8,2,5,1]`和`[27,10,14,9,8,26]`。
 
 由于存在这些差异，Hoare快速排序的实施略有不同：
 */
func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionHoare(&a, low: low, high: high)
        quicksortHoare(&a, low: low, high: p)
        quicksortHoare(&a, low: p + 1, high: high)
    }
}

/*:
 ## 选择一个好的基准
 
 **Lomuto的分区方案总是为基准选择最后一个数组元素。 Hoare的分区方案使用第一个元素。 但这都不能保证这些基准是好的。**
 
 理想情况下，基准是您要分区的数组的 中位数（译注：大小在中间的） 元素，即位于排玩序数组中间的元素。当然，在你对数组进行排序之前，你不会知道中位数是什么，所以这就回到 鸡蛋和鸡 问题了。然而，有一些技巧可以改进。
 
 一个技巧是“三个中间值”，您可以在找到数组中第一个，中间和最后一个的中位数。 从理论上讲，这通常可以很好地接近真实的中位数。
 
 **另一种常见的解决方案是随机选择基准。** 有时这可能会选择次优的基准，但平均而言，这会产生非常好的结果。
 
 以下是如何使用随机选择的基准进行快速排序：
 */

public func random(min: Int, max: Int) -> Int {
    assert(min < max)
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}
func quicksortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = random(min: low, max: high)
        
        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])
        
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortRandom(&a, low: low, high: p - 1)
        quicksortRandom(&a, low: p + 1, high: high)
    }
}
/*:
 与之前有两个重要的区别：
 
 1. `random(min:max:)`函数返回`min...max`范围内的整数，这是我们基准的索引。
 2. 因为Lomuto方案期望`a[high]`成为基准，我们将`a[pivotIndex]`与`a[high]`交换，将基准元素放在末尾，然后再调用`partitionLomuto()`。

 在类似排序函数中使用随机数似乎很奇怪，但让快速排序在所有情况下都能有效地运行，这是有必要的。 坏的基准，快速排序的表现可能非常糟糕，O(n^2)。 **但是如果平均选择好的基准，例如使用随机数生成器，预期的运行时间将变为O(nlogn)，这是好的排序算法。**

 ## 荷兰国旗🇳🇱分区
 还有更多改进！ 在我向您展示的第一个快速排序示例中，我们最终得到了一个像这样分区的数组：
 ```
 [ values < pivot | values equal to pivot | values > pivot ]
 ```
 */
public func swap<T>(_ a: inout [T], _ i: Int, _ j: Int) {
    if i != j {
        a.swapAt(i, j)
    }
}
func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    let pivot = a[pivotIndex]
    
    var smaller = low
    var equal = low
    var larger = high
    
    while equal <= larger {
        if a[equal] < pivot {
            swa
        }
    }
}
