import UIKit

//var str = "Hello, playground"
/*
 来自：
 
 [Boyer-Moore字符串搜索(Boyer-Moore String Search)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Boyer-Moore-Horspool)
 
 [Boyer-Moore-Horspool](https://github.com/andyRon/swift-algorithm-club/tree/master/Boyer-Moore-Horspool)
 */
extension String {
    func index(of pattern: String) -> String.Index? {
        
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= self.count else { return nil }
        //创建skipTable
        var skipTable = [Character: Int]()
        for (i, c) in pattern.enumerated() {
            skipTable[c] = patternLength - i - 1
        }
        print("skipTable: ", skipTable)
        //获取lastChar
        let p = pattern.index(before: pattern.endIndex)
        let lastChar = pattern[p]
        print("lastChar: ", lastChar)
        
        var i = index(startIndex, offsetBy: patternLength - 1)
        
        func backwards() -> Index? {
            var q = p
            var j = i
            while q > pattern.startIndex {
                j = index(before: j)
                q = index(before: q)
                if self[j] != pattern[q] { return nil }
            }
            return j
        }
        while i < endIndex {
            let c = self[i]
            print("i = \(i.utf16Offset(in: "")), c = \(c), lastChar = \(lastChar), endIndex = \(endIndex.utf16Offset(in: ""))")
            if c == lastChar {
                if let k = backwards() {
                    print("k = ", k.utf16Offset(in: ""))
                    return k
                }
                i = index(after: i)
            } else {
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy:  endIndex) ?? endIndex
            }
        }
        return nil
    }
}
let sourceString = "Hello, World"
let pattern = "World"
//print( sourceString.index(of: pattern)?.utf16Offset(in: "") ?? 0 )
/*
 打印结果：
 skipTable:  ["W": 4, "r": 2, "l": 1, "o": 3, "d": 0]
 lastChar:  d
 i = 4, c = o, lastChar = d, endIndex = 12
 i = 7, c = W, lastChar = d, endIndex = 12
 i = 11, c = d, lastChar = d, endIndex = 12
 k =  7
 7
 */

//: ## Boyer-Moore-Horspool 算法

extension String {
    func index(of pattern: String, usingHorspoolImprovement: Bool = false) -> Index? {
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= self.count else {
            return nil
        }
        //创建skipTable
        var skipTable = [Character: Int]()
        for (i, c) in pattern.enumerated() {
            skipTable[c] = patternLength - i - 1
        }
        print("skipTable: ", skipTable)
        
        //获取lastChar
        let p = pattern.index(before: pattern.endIndex)
        let lastChar = pattern[p]
        print("lastChar: ", lastChar)
        
        var i = index(startIndex, offsetBy: patternLength - 1)
        
        func backwards() -> Index? {
            var q = p
            var j = i
            while q > pattern.startIndex {
                j = index(before: j)
                q = index(before: q)
                if self[j] != pattern[q] { return nil }
            }
            return j
        }
        while i < endIndex {
            let c = self[i]
            print("i = \(i.utf16Offset(in: "")), c = \(c), lastChar = \(lastChar), endIndex = \(endIndex.utf16Offset(in: ""))")
            
            if c == lastChar {
                if let k = backwards() {
                    print("k = ", k.utf16Offset(in: ""))
                    return k
                }
                
                if !usingHorspoolImprovement {
                    i = index(after: i)
                    print("true_i = \(i.utf16Offset(in: ""))")
                } else {
                    let jumpOffset = max(skipTable[c] ?? patternLength, 1)
                    i = index(i, offsetBy: jumpOffset, limitedBy: endIndex) ?? endIndex
                    print("false_i = \(i.utf16Offset(in: "")), jumpOffset = \(jumpOffset)")
                }
            } else {
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
}
print( sourceString.index(of: pattern, usingHorspoolImprovement: false)?.utf16Offset(in: "") ?? 0 )
/*
 打印结果：
 //usingHorspoolImprovement = true
 skipTable:  ["W": 4, "l": 1, "o": 3, "d": 0, "r": 2]
 lastChar:  d
 i = 4, c = o, lastChar = d, endIndex = 12
 i = 7, c = W, lastChar = d, endIndex = 12
 i = 11, c = d, lastChar = d, endIndex = 12
 k =  7
 7
 */

//: 在实践中，Horspool版本的算法往往比原始版本略好一些。 但是，这取决于你愿意做出什么样的权衡。
