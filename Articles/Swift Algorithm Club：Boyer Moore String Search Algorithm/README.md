# 翻译：Swift Algorithm Club: Boyer Moore String Search Algorithm


来自：[Swift Algorithm Club: Boyer Moore String Search Algorithm](https://www.raywenderlich.com/541-swift-algorithm-club-boyer-moore-string-search-algorithm)

---
学习如何在Swift中使用Boyer Moore算法搜索字符串。

[Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club)是一个在Swift中实现数据结构和算法的开源项目。

每个月，[Vincent Ngo](https://www.raywenderlich.com/u/jomoka), [Ross O 'Brien](https://www.raywenderlich.com/u/narrativium)和我都会在这个网站的教程中介绍一个来自俱乐部的很酷的数据结构或算法。

在这个教程中，你将会分析2个算法：

1. [Matthijs Hollemans](https://github.com/hollance) 的[蛮力](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Brute-Force%20String%20Search)字符串搜索
2. 由[Matthijs Hollemans](https://github.com/hollance)设计的[Boyer Moore](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Boyer-Moore)字符串搜索

> **NOTE**
> 这是为Xcode 9Beta 2/Swift 4编写的。你可以在[这里](https://developer.apple.com/download/)下载Xcode beta。
> 
## 开始
说明字符串搜索算法在世界上有多么重要是相当简单的。按下`CMD` + `F`，试着搜索字母`c`。你会立即得到结果。现在想象一下，如果计算这个花费了10秒钟，那么您最好退休!

## 对它使用蛮力！
蛮力法相对简单。要理解蛮力字符串方法，请考虑字符串“HELLO WORLD”:

![](./Images/1.png)
对于本教程的目的，有几件事需要记住。

1. 你的搜索算法应该区分大小写。
2. 该算法应该返回第一个匹配项的索引。
3. 部分匹配应该有效。例如：

```swift
let text = "HELLO WORLD"
text.index(of: "ELLO") // returns 1
text.index(of: "LD") // returns 9
```

算法相当简单。例如，假设您正在寻找样模式“LO”。首先遍历源字符串。一旦找到与查找字符串的第一个字符匹配的字符，就会尝试匹配其他字符。否则，您将继续匹配其余的字符串:

！[](./Images/2.gif)

### 实现
你将把这个方法写出`String`的`extension`。用Xcode 9 beta 2或更高版本，创建一个新的Swift playground。删除样板代码，这样您就有了一个空白的playground页面。首先在`String`扩展内创建实现的存根（stub）。在你的playground的顶部写下下面的内容：
```swift
extension String {
  func index(of pattern: String) -> Index? {
    // more to come
    return nil
  }
}
```
这个函数的目的很简单:给定一个字符串(这里称为**源字符串**)，检查它是否包含另一个字符串(这里称为**模式**)。如果可以进行匹配，它将返回匹配的第一个字符的索引。如果这个方法找不到匹配项，它将返回`nil`。

从Swift 4开始，`String`暴露了 `indices` 属性，该属性包含用于下标字符串的所有索引。您将使用它来遍历源字符串。更新函数如下:
```swift
func index(of pattern: String) -> Index? {
  // 1
  for i in indices {

    // 2
    var j = i
    var found = true
    for p in pattern.indices {
      guard j != endIndex && self[j] == pattern[p] else { found = false; break }
      j = index(after: j)
    }
    if found {
      return i
    }
  }
  return nil
}
```
这正是你想要的：

1. 循环源字符串的索引。
2. 尝试将模式字符串与源字符串匹配。

一旦找到匹配项，就会返回索引。是时候进行测试了。在你的playground底部写下以下内容: