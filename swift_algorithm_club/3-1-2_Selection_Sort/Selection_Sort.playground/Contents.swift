import UIKit

//var str = "Hello, playground"

/*:
 来自：
 [选择排序(Selection Sort)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Selection%20Sort)
 
 [Selection Sort](https://github.com/andyRon/swift-algorithm-club/tree/master/Selection%20Sort)
 */

/*:
 
 它的工作原理如下：
 
 1. 找到数组中的最小数字。 从索引0开始，遍历数组中的所有数字，并追踪最小数字的位置。
 2. 使用索引0处的数字交换最小数字。现在，已排序部分仅包含索引0处的数字。
 3. 转到索引1处。
 4. 找到数组其余部分中的最小数字。 从索引1开始查看。再次循环直到数组结束并追踪最小数字。
 5. 使用索引1处的数字交换最小数字。现在，已排序部分包含两个数字，索引0和索引1。
 6. 转到索引2处。
 7. 从索引2开始，找到数组其余部分中的最小数字，并将其与索引2处的数字交换。现在，数组从索引0到2已排序; 此范围包含数组中的三个最小数字。
 8. 并继续，直到没有数字需要排序。

 */

//: ## 代码
func selectionSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array } // 1
    
    var a = array                               // 2
    
    for x in 0 ..< a.count - 1 {                // 3
        var lowest = x
        for y in x + 1 ..< a.count {            // 4
            if a[y] < a[lowest] {
                lowest = y
            }
        }
        
        if x != lowest {                        // 5
            a.swapAt(x, lowest)
        }
    }
    return a
}

//测试
let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
print( selectionSort(list) )    // [-1, 0, 1, 2, 3, 3, 5, 8, 9, 10, 26, 27]

/*:
 代码逐步说明：
 
 1. 如果数组为空或仅包含单个元素，则无需排序。
 
 2. 生成数组的副本。 这是必要的，因为我们不能直接在Swift中修改array参数的内容。 与Swift的sort()函数一样，selectionSort()函数将返回排完序的原始数组拷贝。
 
 3. 函数内有两个循环。 外循环依次查看数组中的每个元素; 这就是向前移动|栏的原因。
 
 4. 内循环实现找到数组其余部分中的最小数字。
 
 5. 使用当前数组索引数字交换最小数字。 if判断是必要的，因为你不能在Swift中swap()同一个元素。
 
 > 译注：Swift中的数组没有`swap()`方法，只有`swapAt()`方法，而且`swapAt()`交换同一个元素是没有问题的。这可能是Swift版本更新的问题。

 */

/*:
 ## 性能
 **选择排序很容易理解，但执行速度慢 O(n^2)。它比[插入排序](https://github.com/andyRon/swift-algorithm-club-cn/blob/master/Insertion%20Sort)更糟，但优于[冒泡排序](https://github.com/andyRon/swift-algorithm-club-cn/blob/master/Bubble%20Sort)。查找数组其余部分中的最低元素很慢，特别是因为内部循环将重复执行。**
 
 [堆排序](https://github.com/andyRon/swift-algorithm-club-cn/blob/master/Heap%20Sort)使用与选择排序相同的原则，但使用了一种快速方法在数组的其余部分中查找最小值。 **堆排序性能是 O(nlogn)**。
 */


