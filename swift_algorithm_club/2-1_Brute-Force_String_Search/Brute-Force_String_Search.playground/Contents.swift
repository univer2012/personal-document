import UIKit

//var str = "Hello, playground"
/*
 来自：[暴力字符串搜索(Brute-Force String Search)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Brute-Force%20String%20Search)
 
 [Brute-Force String Search](https://github.com/andyRon/swift-algorithm-club/tree/master/Brute-Force%20String%20Search)
 */

//: 暴力解决方案：

extension String {
    func indexOf(_ pattern: String) -> String.Index? {
        for i in self.indices {
            var j = i
            var found = true
            for p in pattern.indices {
                if j == self.endIndex || self[j] != pattern[p] {
                    found = false
                    break
                } else {
                    j = self.index(after: j)
                }
            }
            if found {
                return i
            }
        }
        return nil
    }
}
//测试

let s = "Hello, World"
s.indexOf("World")?.utf16Offset(in: "")     // 7

let animals = "🦍🐢🐡🐮🦖🐋🐶🐬🐠🐔🐷🐙🐮🦟🦂🦜🦢🐨🦇🐐🦓"
animals.indexOf("🐮")?.utf16Offset(in: "")  // 12
/*:
 > 注意： 牛的索引是12，而不是你想象的3，因为字符串为表情符号使用更多的存储空间。 String.Index的实际值并不那么重要，只要它指向字符串中的正确字符。
 
 暴力方法运行正常，但效率不高（或漂亮）。 不过，暴力方法应该可以在小字符串上正常工作。 对于使用大块文本更好的智能算法，请查看[Boyer-Moore](https://github.com/andyRon/swift-algorithm-club-cn/blob/master/Boyer-Moore-Horspool)字符串搜索。
 */

