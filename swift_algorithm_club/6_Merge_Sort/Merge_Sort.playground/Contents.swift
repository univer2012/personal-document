import UIKit

//var str = "Hello, playground"
/*
 来自：[归并排序（Merge Sort）](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Merge%20Sort)
 [Merge Sort](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Merge%20Sort)
 */

//: ## 自上而下的实施(递归法)
//归并排序的Swift实现：
func mergeSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }     // 1
    
    let middleIndex = array.count / 2               // 2
    let leftArray = mergeSort(Array(array[0 ..< middleIndex]))              // 3
    
    let rightArray = mergeSort(Array(array[middleIndex ..< array.count]))   // 4
    
    return merge(leftPile: leftArray, rightPile: rightArray)                // 5
}
/*:
 代码的逐步说明：
 
 1. 如果数组为空或包含单个元素，则无法将其拆分为更小的部分，返回数组就行。
 
 2. 找到中间索引。
 
 3. 使用上一步中的中间索引，递归地分割数组的左侧。
 
 4. 此外，递归地分割数组的右侧。
 
 5. 最后，将所有值合并在一起，确保它始终排序。
*/

//: 合并算法
func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
    // 1
    var leftIndex = 0
    var rightIndex = 0
    
    // 2
    var orderedPile = [Int]()
    
    // 3
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    // 4
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}
/*:
 代码解释：
 
 1. 在合并时，您需要两个索引来跟踪两个数组的进度。
 
 2. 这是合并后的数组。 它现在是空的，但是你将在下面的步骤中通过添加其他数组中的元素构建它。
 
 3. 这个`while`循环将比较左侧和右侧的元素，并将它们添加到`orderedPile`，同时确保结果保持有序。
 
 4. 如果前一个`while`循环完成，则意味着`leftPile`或`rightPile`中的一个的内容已经完全合并到`orderedPile`中。此时，您不再需要进行比较。只需依次添加剩下一个数组的其余内容到`orderedPile`。

 */


/*:
 ## 自下而上的实施(迭代)
 结合 xexcel表格来分析
 */


func mergeSortBottomUp<T>(_ a: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    let n = a.count
    
    var z = [a, a]      // 1
    var d = 0
    
    var width = 1
    while width < n {   // 2
        var i = 0
        while i < n {   // 3
            var j = i
            var l = i
            var r = i + width
            
            let lmax = min(l + width, n)
            let rmax = min(r + width, n)
            
            while l < lmax && r < rmax {                // 4
                if isOrderedBefore(z[d][l], z[d][r]) {
                    z[1 - d][j] = z[d][l]
                    l += 1
                } else {
                    z[1 - d][j] = z[d][r]
                    r += 1
                }
                j += 1
            }
            
            while l < lmax {
                z[1 - d][j] = z[d][l]
                j += 1
                l += 1
            }
            while r < rmax {
                z[1 - d][j] = z[d][r]
                j += 1
                r += 1
            }
            i += width * 2
        }
        width *= 2
        d = 1 - d           // 5
    }
    return z[d]
}

/*:
 
 它看起来比自上而下的版本更令人生畏，但请注意主体包含与merge()相同的三个while循环。
 
 值得注意的要点：
 
 1. 归并排序算法需要一个临时工作数组，因为你不能合并左右堆并同时覆盖它们的内容。 因为为每个合并分配一个新数组是浪费，我们使用两个工作数组，我们将使用d的值在它们之间切换，它是0或1。数组z[d]用于读，z[1 - d]用于写。 这称为 **双缓冲**。
 
 2. 从概念上讲，自下而上版本的工作方式与自上而下版本相同。首先，它合并每个元素的小堆，然后它合并每个堆两个元素，然后每个堆成四个元素，依此类推。堆的大小由width给出。 最初，width是1但是在每次循环迭代结束时，我们将它乘以2，所以这个外循环确定要合并的堆的大小，并且要合并的子数组在每一步中变得更大。
 
 3. 内循环穿过堆并将每对堆合并成一个较大的堆。 结果写在z[1 - d]给出的数组中。
 
 4. 这与自上而下版本的逻辑相同。 主要区别在于我们使用双缓冲，因此从z[d]读取值并写入z [1 - d]。它还使用isOrderedBefore函数来比较元素而不仅仅是<，因此这种合并排序算法是通用的，您可以使用它来对任何类型的对象进行排序。
 
 5. 此时，数组`z[d]`的大小`width`的堆已经合并为数组`z[1-d]`中更大的大小`width * 2`。在这里，我们**交换活动数组，以便在下一步中我们将从我们刚刚创建的新堆中读取**。
 
 这个函数是通用的，所以你可以使用它来对你想要的任何类型对象进行排序，只要你提供一个正确的`isOrderedBefore`闭包来比较元素。
 */

//测试
let array = [2, 1, 5, 4, 9]
print( mergeSortBottomUp(array, <) )    // [1, 2, 4, 5, 9]


//
