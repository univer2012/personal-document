import UIKit

//var str = "Hello, playground"
/*
 来自：
 [Z-算法字符串搜索](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Z-Algorithm)
 
 [Z-Algorithm](https://github.com/andyRon/swift-algorithm-club/tree/master/Z-Algorithm)
 */
//: ## Z-算法作为模式预处理器

/*:
 但是我们如何计算Z？
 
 在我们描述算法之前，我们必须产生Z-box的概念。 Z-box是在计算过程中使用的一对(left, right)，它记录了最大长度的子串，它也作为P的前缀出现。两个索引left和right分别表示该子字符串的左端索引和右端索引。
 */
func ZetaAlgorithm(ptnr: String) -> [Int]? {
    let pattern = Array(ptnr)
    let patternLength: Int = pattern.count
    
    guard patternLength > 0 else { return nil }
    
    var zeta: [Int] = [Int](repeating: 0, count: patternLength)
    
    var left: Int = 0
    var right: Int = 0
    var k_1: Int = 0
    var betaLength: Int = 0
    var textIndex: Int = 0
    var patternIndex: Int = 0
    
    for k in 1 ..< patternLength {
        if k > right {
            print("第\(k)轮：k = \(k)")
            patternIndex = 0
            
            while k + patternIndex < patternLength &&
                pattern[k + patternIndex] == pattern[patternIndex] {
                    patternIndex = patternIndex + 1
            }
            
            zeta[k] = patternIndex
            
            if zeta[k] > 0 {
                left = k
                right = k + zeta[k] - 1
            }
        } else {
            k_1 = k - left
            betaLength = right - k + 1
            
            if zeta[k_1] < betaLength {
                zeta[k] = zeta[k_1]
            } else if zeta[k_1] >= betaLength {
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
            print("k_1 = \(k_1), betaLength = \(betaLength),zeta[\(k)] = \(zeta[k])")
        }
    }
    return zeta
}

//测试
let P = "abababbb"

print( ZetaAlgorithm(ptnr: P) )  //[0, 0, 4, 0, 2, 0, 0, 0]


//: ## Z-算法作为字符串搜索算法
extension String {
    func indexesOf(pattern: String) -> [Int]? {
        let patternLength: Int = pattern.count
        /* Let's calculate the Z-Algorithm on the concatenation of pattern and text */
        let zeta = ZetaAlgorithm(ptnr: pattern + "$" + self)
        //print("zeta = \(zeta)")
        //[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0, 0, 1, 3, 0, 0]
        
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
//测试
let P1 = "CATA"
let T = "GAGAACATACATGACCAT"
print( T.indexesOf(pattern: P1) )


/*:
 如前所述，该算法的复杂性是线性的。 将n和m定义为模式和文本长度，我们得到的最终复杂度是“O（n + m + 1）= O（n + m）”。
 */
