## 快速排序的Lomuto的分区方案 例子

例子：
```swift
var list = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
let p = partitionLomuto(&list, low: 0, high: list.count - 1)
```

初始值：
```
pivot = 8
low = 0
high = 12
```

第1轮：
```
i = 0
j = 0
a[0]> 8
```
第2轮：
```swift
i=0
j=1
a[1]<= 8
//结果：  a[0]和a[1]交换,i +=1
a = [0, 10, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8]
i = 1
```

第3轮：
```
i = 1
j = 2
a[2] <= 8
//结果：  a[1]和a[2]交换,i +=1
a = [0, 3, 10, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8]
i = 2
```

第4轮：
```
i = 2
j = 3
a[3] > 8
```

第5轮：
```
i = 2
j = 4
a[4] <= 8
//结果：  a[2]和a[4]交换,i +=1
a = [0, 3, 2, 9, 10, 14, 26, 27, 1, 5, 8, -1, 8]
i = 3
```

第6轮：
```
i = 3
j = 5
a[5] > 8
```

第7轮：
```
i = 3
j = 6
a[6] > 8
```
第8轮：
```
i = 3
j = 7
a[7] > 8
```

第9轮：
```
i = 3
j = 8
a[8] <= 8
//结果：  a[3]和a[8]交换,i +=1
a = [0, 3, 2, 1, 10, 14, 26, 27, 9, 5, 8, -1, 8]
i = 4
```

第10轮：
```
i = 4
j = 9
a[9] <= 8
//结果：  a[4]和a[9]交换,i +=1
a = [0, 3, 2, 1, 5, 14, 26, 27, 9, 10, 8, -1, 8]
i = 5
```

第11轮：
```
i = 5
j = 10
a[10] <= 8
//结果：  a[5]和a[10]交换,i +=1
a = [0, 3, 2, 1, 5, 8, 26, 27, 9, 10, 14, -1, 8]
i = 6
```

第12轮：
```
i = 6
j = 11
a[11] <= 8
//结果：  a[6]和a[11]交换,i +=1
a = [0, 3, 2, 1, 5, 8, -1, 27, 9, 10, 14, 26, 8]
i = 7
```
因为`j`在`0 ...< 12`之间取值，所以循环结束
最后：交换`a[i], a[high]`的值，变为
```
a = [0, 3, 2, 1, 5, 8, -1, 8, 9, 10, 14, 26, 27]
```


总结：`i`最后是`pivot`的位置，是`less`分区的结束。

变量`p`是`partitionLomuto()`的调用的返回值，是7。这是新数组中的基准元素的索引（用星号标记）。

左分区从`0`到`p-1`，是`[0,3,2,1,5,8，-1]`。 右分区从`p + 1`到结尾，并且是`[9,10,14,26,27]`（右分区已经排序的实属是巧合）。

您可能会注意到一些有趣的东西......值8在数组中出现不止一次。 其中一个`8`并没有整齐地在中间，而是在左分区。** 这是Lomuto算法的一个小缺点，如果存在大量重复元素，它会使快速排序变慢。**

那么Lomuto算法实际上是如何工作的呢？ 魔术发生在`for`循环中。 此循环将数组划分为四个区域：

1. `a [low ... i]` 包含 `<= pivot` 的所有值
2. `a [i + 1 ... j-1]` 包含 `> pivot` 的所有值
3. `a [j ... high-1]` 是我们“未查看”的值
4. `a [high]`是基准值

用ASCII字符表示，数组按如下方式划分：
```
[ values <= pivot | values > pivot | not looked at yet | pivot ]
  low           i   i+1        j-1   j          high-1   high
```

循环依次查看从`low`到`high-1`的每个元素。 如果当前元素的值小于或等于基准，则使用`swap`将其移动到第一个区域。

> 注意： 在Swift中，符号`(x, y) = (y, x)`是在`x`和`y`的值之间执行交换的便捷方式。 你也可以使用`swap(＆x，＆y)`。
> 

##  使用Lomuto分区方案来构建快速排序
让我们使用这个分区方案来构建快速排序。 这是代码：
```swift
func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: p - 1)
        quicksortLomuto(&a, low: p + 1, high: high)
    }
}
```

 Lomuto方案不是唯一的分区方案，但它可能是最容易理解的。 它不如Hoare的方案有效，后者需要的交换操作更少。
 
 ## Hoare的分区方案
 **这种分区方案是由快速排序的发明者Hoare完成的。**
```swift
func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1
    
    while true {
        repeat { j -= 1 } while a[j] > pivot
        repeat { i += 1 } while a[i] < pivot
        
        if i < j {
            a.swapAt(i, j)
        } else {
            return j
        }
    }
}
```

```swift
//测试
var list3 = [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 ]
let p = partitionHoare(&list3, low: 0, high: list3.count - 1)
print("p = \(p), list3 = \(list3)")
//打印： p = 6, list3 = [-1, 0, 3, 8, 2, 5, 1, 27, 10, 14, 9, 8, 26]
```

### 例子分析
初始值
```
a = [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 ]
low = 0
high = 12
pivot = 8
i = -1
j = 13
```
第1轮：
```
j = 12, a[12] > 8 
```
第2轮：
```
j = 11, a[11] < 8
i = 0, a[0] = 8
/*交换i,j的值:
位置:     0	 1  2  3  4  5   6   7   8  9 10  11  12
				 i																		j
变化前: [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26]
变化后: [-1, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8,  8, 26]
*/
```
第3轮：
```
j = 10, a[10] = 8
i = 1, a[1] < 8
```
第4轮：
```
j = 10
i = 2, a[2] < 8
```
第5轮：
```
j = 10
i = 3, a[3] > 8
/*交换i,j的值:
位置:     0	 1  2  3  4  5   6   7  8  9  10  11  12
				 					i												j
变化前: [-1, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8,  8, 26]
变化后: [-1, 0, 3, 8, 2, 14, 10, 27, 1, 5, 9,  8, 26]
*/
```
第6轮：
```
j = 9, a[9] < 8
i = 4, a[4] < 8
```
第7轮：
```
j = 9
i = 5, a[5] > 8
/*交换i,j的值:
位置:     0	 1  2  3  4  5   6   7   8  9  10  11  12
				 					       i						 j
变化前: [-1, 0, 3, 8, 2, 14, 10, 27, 1, 5,  9,  8, 26]
变化后: [-1, 0, 3, 8, 2, 5,  10, 27, 1, 14, 9, 8, 26]
*/
```
第8轮：
```
j = 8, a[8] < 8
i = 6, a[6] > 8
/*交换i,j的值:
位置:     0	 1  2  3  4  5   6   7   8  9  10  11  12
				 					          i				j
变化前: [-1, 0, 3, 8, 2, 5,  10, 27, 1, 14, 9, 8, 26]
变化后: [-1, 0, 3, 8, 2, 5,  1,  27, 10,14, 9, 8, 26]
*/
```
第9轮：
```
j = 7, a[7] > 8
```
第10轮：
```
j = 6, a[6] < 8
i = 7, a[7] > 8
//结束,返回 j = 6
```


 请注意，这次基准根本不在中间。 与Lomuto的方案不同，返回值不一定是新数组中基准元素的索引。
 
 结果，数组被划分为区域`[low ... p]`和`[p + 1 ... high]`。 这里，返回值`p`是`6`，因此两个分区是`[-1,0,3,8,2,5,1]`和`[27,10,14,9,8,26]`。
 
 由于存在这些差异，Hoare快速排序的实施略有不同：
 ```swift
func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionHoare(&a, low: low, high: high)
        quicksortHoare(&a, low: low, high: p)
        quicksortHoare(&a, low: p + 1, high: high)
    }
}
```