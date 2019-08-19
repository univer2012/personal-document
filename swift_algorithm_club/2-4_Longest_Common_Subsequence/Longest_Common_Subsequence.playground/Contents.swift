import UIKit

//var str = "Hello, playground"


/*
 来自：
 [最长公共子序列](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Longest%20Common%20Subsequence)
 [Longest Common Subsequence](https://github.com/andyRon/swift-algorithm-club/tree/master/Longest%20Common%20Subsequence)
 */


extension String {
    // : ## 3. 把它们放在一起
    public func longestCommonSubsequence(_ other: String) -> String {
        
        //: ## 1.通过动态编程查找LCS的长度
        func lcsLength(_ other: String) -> [[Int]] {
            var matrix = [[Int]](repeating: [Int](repeating: 0, count: other.count + 1), count: self.count + 1)
            
            for (i, selfChar) in self.enumerated() {
                for (j, otherChar) in other.enumerated() {
                    if otherChar == selfChar {
                        // Common char found, add 1 to highest lcs found so far.
                        matrix[i + 1][j + 1] = matrix[i][j] + 1
                    } else {
                        // Not a match, propagates highest lcs length found so far.
                        matrix[i + 1][j + 1] = max(matrix[i][j + 1], matrix[i + 1][j])
                    }
                }
            }
            //打印
            matrix.filter { (columnArr) -> Bool in
                print("\(columnArr)")
                return true
            }
            
            return matrix
        }
        
        //: ## 2.回溯找到实际的子序列
        func backtrack(_ matrix: [[Int]]) -> String {
            var i = self.count
            var j = other.count
            
            var charInSequence = self.endIndex
            
            var lcs = String()
            
            while i >= 1 && j >= 1 {
                if matrix[i][j] == matrix[i][j - 1] {
                    j -= 1
                }
                else if matrix[i][j] == matrix[i - 1][j] {
                    i -= 1
                    charInSequence = self.index(before: charInSequence)
                }
                else {
                    i -= 1
                    j -= 1
                    charInSequence = self.index(before: charInSequence)
                    print("charInSequence = \(charInSequence.utf16Offset(in: "")), self[\(charInSequence.utf16Offset(in: ""))] = \(self[charInSequence])")
                    lcs.append(self[charInSequence])
                }
            }
            return String(lcs.reversed())
        }
        
        
        return backtrack(lcsLength(other))
    }
 
}

//测试
let a = "ABCBX"
let b = "ABDCAB"
print( a.longestCommonSubsequence(b) ) //// "ABCB"

let c = "KLMK"
print( a.longestCommonSubsequence(c) ) // "" (no common subsequence)

print( "Hello World".longestCommonSubsequence("Bonjour le monde") )  // "oorld"
//print(  )
