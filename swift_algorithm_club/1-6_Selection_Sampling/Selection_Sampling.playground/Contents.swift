import UIKit

/*
 来自：[选取样本](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Selection%20Sampling)
 [Selection Sampling](https://github.com/andyRon/swift-algorithm-club/tree/master/Selection%20Sampling)
 */
//var str = "Hello, playground"

func random(min: Int, max: Int) -> Int {
    return Int(arc4random()) % (max - min) + min
}

#if false
//: ## 1
//: 这是一个非常快的版本：
func select<T>(from a: [T], count k: Int) -> [T] {
    var a = a
    for i in 0 ..< k {
        let r = random(min: i, max: a.count - 1)
        if i != r {
            a.swapAt(i, r)
        }
    }
    return Array(a[0 ..< k])
}
//测试
let array = [ "a", "b", "c", "d", "e", "f", "g" ]
print(select(from: array, count: 5))
#endif


//: ## 2
//: 这是一种替代算法，称为“水库采样”：

func reservoirSample<T>(from a: [T], count k: Int) -> [T] {
    precondition(a.count >= k)
    
    var result = [T]()  // 1 使用原始数组中的第一个k元素填充result数组。 这被称为“水库”
    for i in 0..<k {
        result.append(a[i])
    }
    
    for i in k ..< a.count {    // 2 用剩余池中的元素随机替换储层中的元素。
        let j = random(min: 0, max: i)
        if j < k {
            result[j] = a[i]
        }
    }
    return result
}
//:  该算法的性能为 O(n)，因此它比第一算法慢一点。 但是，它的最大优点是它可以用于太大而无法容纳在内存中的数组，即使你不知道数组的大小是什么


//: ## 3
func select<T>(from a: [T], count requested: Int) -> [T] {
    var examined = 0    //已经检查过的数量
    var selected = 0    //符合的已选择的数量
    var b = [T]()
    // requested  : 要求的数量
    while selected < requested {                            // 1
        let r = Double(arc4random()) / 0x100000000          // 2
        //leftToExamine: 还没有看过的数量
        let leftToExamine = a.count - examined              // 3
        let leftToAdd = requested - selected    //在完成之前还需要选择的项目数。
        
        let toExamine = Double(leftToExamine) * r
        let toAdd = Double(leftToAdd)
        var should = false
        
        if toExamine < toAdd {  // 4
            selected += 1
            b.append(a[examined])
            should = true
        }
        print("\(Double(leftToExamine)) * \(r) = \(toExamine) < \(toAdd)? ", should ? "YES" : "NO")
        
        examined += 1
    }
    return b
}
/*: 该算法使用概率来决定是否在选择中包括数字。
 
 1. 循环从头到尾逐步完成数组。 它一直持续到我们从n的集合中选择k项目。 这里，`k`被称为`requested`而`n`被称为`a.count`。
 
 2. 计算0到1之间的随机数。我们想要`0.0 <= r <1.0`。 上限是排他性的; 我们从不希望它完全是1。这就是为什么我们将结果从`arc4random()`除以`0x100000000`而不是更常见的`0xffffffff`。
 
 3. `leftToExamine`是我们还没有看过多少项。 `leftToAdd`是我们在完成之前还需要选择的项目数。
 
 4. 这就是魔术发生的地方。 基本上，我们正在翻转一枚硬币。 如果是head，我们将当前数组元素添加到选择中; 如果它是尾巴，我们跳过它。

 */
//测试
let array1 = [ "a", "b", "c", "d", "e", "f", "g" ]
print(select(from: array1, count: 5))

//测试2
let input = [
    "there", "once", "was", "a", "man", "from", "nantucket",
    "who", "kept", "all", "of", "his", "cash", "in", "a", "bucket",
    "his", "daughter", "named", "nan",
    "ran", "off", "with", "a", "man",
    "and", "as", "for", "the", "bucket", "nan", "took", "it",
]
let output = select(from: input, count: 10)
print(output)
print(output.count)

/*: 缺点：由于越往后，还没有看过的数量，即leftToExamine 值越小，在随机数r等机会的情况下，后面的项被选中的概率会越高。
 我们可以从
 ```
 if Double(leftToExamine) * r < Double(leftToAdd) {
    selected += 1
    b.append(a[examined])
 }
 ```
 代码中可以看出，r在相等机会的情况下，因为越往后，已选中的项会越来越多，导致还需选中的数量leftToExamine会越来越小直至为0，此时  Double(leftToExamine) * r的值会越来越小，即越往后的项，被选中的概率会越高。
 */
