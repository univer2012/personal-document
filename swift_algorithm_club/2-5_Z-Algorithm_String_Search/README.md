# Z-算法字符串搜索


来自：

1. 中文：[Z-Algorithm String Search](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Z-Algorithm)
2. 英文：[Z-Algorithm](https://github.com/andyRon/swift-algorithm-club/tree/master/Z-Algorithm)

---


## Z-算法作为模式预处理器

以下是计算Z数组的函数的代码：
```swift
func ZetaAlgorithm(ptrn: String) -> [Int]? {

    let pattern = Array(ptrn.characters)
    let patternLength: Int = pattern.count

    guard patternLength > 0 else {
        return nil
    }

    var zeta: [Int] = [Int](repeating: 0, count: patternLength)

    var left: Int = 0
    var right: Int = 0
    var k_1: Int = 0
    var betaLength: Int = 0
    var textIndex: Int = 0
    var patternIndex: Int = 0

    for k in 1 ..< patternLength {
        if k > right {  // Outside a Z-box: compare the characters until mismatch
            patternIndex = 0

            while k + patternIndex < patternLength  &&
                pattern[k + patternIndex] == pattern[patternIndex] {
                patternIndex = patternIndex + 1
            }

            zeta[k] = patternIndex

            if zeta[k] > 0 {
                left = k
                right = k + zeta[k] - 1
            }
        } else {  // Inside a Z-box
            k_1 = k - left + 1
            betaLength = right - k + 1

            if zeta[k_1 - 1] < betaLength { // Entirely inside a Z-box: we can use the values computed before
                zeta[k] = zeta[k_1 - 1]
            } else if zeta[k_1 - 1] >= betaLength { // Not entirely inside a Z-box: we must proceed with comparisons too
                textIndex = betaLength
                patternIndex = right + 1

                while patternIndex < patternLength && pattern[textIndex] == pattern[patternIndex] {
                    textIndex = textIndex + 1
                    patternIndex = patternIndex + 1
                }

                zeta[k] = patternIndex - k
                left = k
                right = patternIndex - 1
            }
        }
    }
    return zeta
}
```
### 分析
让我们用上面的代码作一个例子推理。 让我们考虑字符串P ="abababbb"。

#### 第1轮 `k = 1`
算法以`k = 1`，`left = right = 0`开头。所以，没有Z-box是“活跃的”因此，因为`k > right`我们 从字符比较 `P[1]`和`P[0]`开始。
```
   01234567
k:  x
   abababbb
   x
Z: 00000000
left:  0
right: 0
```

我们在第一次比较时有不匹配，所以从`P [1]`开始的子串与P的前缀不匹配。 所以，我们把`Z [1] = 0`并让`left`和`right`保持不变，即`left = 0, right = 0`。

结果：`zeta[1] = 0`

#### 第2轮 `k = 2`
用`k = 2`开始另一次迭代，我们有`2> 0`并且我们再次开始将字符`P [2]`与`P [0]`进行比较。 这次字符匹配，因此我们继续比较直到发生不匹配。它发生在位置“6”。此时`patternIndex = 4`，所以我们把`Z[2] = 4`并设置`left = k = 2`和`right = k + Z [k] - 1 = 5`。

我们有第一个Z-box，它是子串"abab"（注意它匹配`P`的前缀），从位置`left = 2`开始。
```
   01234567
k:   x
   abababbb
   x
Z: 00400000
left:  2
right: 5
```

结果： `Z[2] = 4`

#### 第3轮 `k = 3`
我们继续`k = 3`。 我们有`3 <= 5`。 我们在之前找到的Z-box里面，在`P`的前缀里面。 因此，我们可以查找具有先前计算值的位置。 我们计算`k_1 = k - left = 1`，它是前缀字符的索引，等于`P[k]`。 我们检查`Z [1] = 0`和`0 < (right - k + 1 = 3)`我们发现我们正好在Z-box内。 我们可以使用先前计算的值，因此我们将`Z [3] = Z [1] = 0`，`left`和`right`保持不变，即`left = 2, right = 5`。

结果： `Z[3] = 0`

#### 第4轮 `k = 4`
在迭代`k = 4`时，我们最初执行外部`if`的`else`分支。然后在内部`if`中我们有`k_1 = 2`和`(Z[2] = 4) > = 5 - 4 + 1`。 因此，子串`P [k ... r]`匹配`right-k + 1 = 2`字符`P`的前缀，但它不能用于后面的字符。 然后我们必须将从`patternIndex = right + 1 = 6`开始的字符与从`textIndex = betaLength = right - k + 1 = 2`开始的字符进行比较。 我们有`pattern[6] != pattern[2]`所以我们必须设置`Z[k] = Z[4] = patternIndex - k = 6 - 4 = 2`，`left = k = 4`和`right = patternIndex - 1 = 5`。
```
   01234567
k:     x
   abababbb
   x
Z: 00402000
left:  4
right: 5
```

结果：`Z[4] = 2`

#### 第5轮 `k = 5`
在迭代`k = 5`时，我们有`k <= right`然后` (Z[k_1] = 0) < (betaLength = right - k + 1 = 1)`所以我们设置`Z[k] = Z[5] = 0`。 `left, right`不变，还是`left = 4, right = 5`。

结果：`Z[5] = 0`

#### 第6、7轮
在迭代6和7中，我们执行外部`if`的第一个分支（因为`k > right`），但我们只有不匹配，即：
`pattern[6] != pattern[0]`，`pattern[7] != pattern[0]`
所以算法终止返回Z数组为`Z = [0,0,4,0,2,0,0,0]`。

**Z算法以线性时间运行。 更具体地说，对于大小为n的字符串P的Z算法具有“O(n)”的运行时间。**

## Z-算法作为字符串搜索算法

上面讨论的`Z`算法导致最简单的线性时间串匹配算法。 为了获得它，我们必须简单地在一个字符串`S = P $ T`中连接模式`P`和文本`T`，其中`$`是一个既不出现在`P`也不出现`T`的字符。 然后我们在`S`上运行算法获得Z阵列。 我们现在要做的就是扫描Z阵列，寻找等于“n”的元素（即模式长度）。 当我们找到这样的值时，我们可以报告一个事件。
```swift
extension String {

    func indexesOf(pattern: String) -> [Int]? {
        let patternLength: Int = pattern.characters.count
        /* Let's calculate the Z-Algorithm on the concatenation of pattern and text */
        let zeta = ZetaAlgorithm(ptrn: pattern + "💲" + self)

        guard zeta != nil else {
            return nil
        }

        var indexes: [Int] = [Int]()

        /* Scan the zeta array to find matched patterns */
        for i in 0 ..< zeta!.count {
            if zeta![i] == patternLength {
                indexes.append(i - patternLength - 1)
            }
        }

        guard !indexes.isEmpty else {
            return nil
        }

        return indexes
    }
}
```

我们举个例子吧。 设`P ="CATA"`和`T ="GAGAACATACATGACCAT"` 是模式和文本。 让我们将它们与字符`$`连接起来。 我们有字符串`S ="CATA$GAGAACATACATGACCAT"`。 在迭代`S`上计算Z算法后，我们得到：
```
            1         2
  01234567890123456789012
  CATA$GAGAACATACATGACCAT
Z 00000000004000300001300
            ^
```

我们扫描Z阵列，在位置“10”，我们发现`Z[10] = 4 = patternLength`。 所以我们可以报告在文本位置`i - patternLength - 1 = 10 - 4 - 1 = 5`发生的匹配。

**如前所述，该算法的复杂性是线性的。 将n和m定义为模式和文本长度，我们得到的最终复杂度是`O(n + m + 1) = O(n + m)`。**