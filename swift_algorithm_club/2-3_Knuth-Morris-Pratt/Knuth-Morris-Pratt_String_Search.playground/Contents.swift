import UIKit

//var str = "Hello, playground"

/*
 来自：
 [KMP算法(Knuth-Morris-Pratt String Search)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Knuth-Morris-Pratt)
 [Knuth-Morris-Pratt](https://github.com/andyRon/swift-algorithm-club/tree/master/Knuth-Morris-Pratt)
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
            k_1 = k - left + 1
            betaLength = right - k + 1
            
            if zeta[k_1 - 1] < betaLength {
                zeta[k] = zeta[k_1 - 1]
            } else if zeta[k_1 - 1] >= betaLength {
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

extension String {
    func indexesOf(ptnr: String) -> [Int]? {
        var text = [Character]()
        for char in self {
            text.append(char)
        }
        var pattern = [Character]()
        for char in ptnr {
            pattern.append(char)
        }
        //print("text = \(text), pattern = \(pattern)" )
        
        let textLength: Int = text.count
        let patternLength: Int = pattern.count
        guard patternLength > 0 else { return nil }
        
        var suffixPrefix: [Int] = [Int](repeating: 0, count: patternLength)
        var textIndex: Int = 0
        var patternIndex: Int = 0
        var indexes: [Int] = [Int]()
        
        let zeta = ZetaAlgorithm(ptnr: ptnr)
        print("zeta = \(zeta)")
        
        for patternIndex in (1 ..< patternLength).reversed() {
            textIndex = patternIndex + zeta![patternIndex] - 1
            suffixPrefix[textIndex] = zeta![patternIndex]
            print("patternIndex = \(patternIndex), textIndex = \(textIndex), suffixPrefix[\(textIndex)] = \(suffixPrefix[textIndex])")
        }
        print("suffixPrefix = \(suffixPrefix)")
        
        textIndex = 0
        patternIndex = 0
        
        while textIndex + (patternLength - patternIndex - 1) < textLength {
            print("\(textIndex) + (\(patternLength) - \(patternIndex) - 1) < \(textLength)")
            print("text[\(textIndex)] = \(text[textIndex]), pattern[\(patternIndex)] = \(pattern[patternIndex])")
            while patternIndex < patternLength && text[textIndex] == pattern[patternIndex] {
                textIndex = textIndex + 1
                patternIndex = patternIndex + 1
            }
            
            if patternIndex == patternLength {
                indexes.append(textIndex - patternIndex) //把匹配了的首下标 存起来
                print("indexes = \(indexes)")
            }
            
            if patternIndex == 0 {
                textIndex = textIndex + 1
                print("patternIndex = \(patternIndex), textIndex = \(textIndex)")
            } else {
                print("patternIndex_before = \(patternIndex)")
                patternIndex = suffixPrefix[patternIndex - 1] //令 patternIndex = 0
                //print("patternIndex_after = \(patternIndex)")
            }
            
        }
        
        guard !indexes.isEmpty else { return nil }

        return indexes
    }
}

//测试
//let dna = "ACCCGGTTTTAAAGAACCACCATAAGATATAGACAGATATAGGACAGATATAGAGACAAAACCCCATACCCCAATATTTTTTTGGGGAGAAAAACACCACAGATAGATACACAGACTACACGAGATACGACATACAGCAGCATAACGACAACAGCAGATAGACGATCATAACAGCAATCAGACCGAGCGCAGCAGCTTTTAAGCACCAGCCCCACAAAAAACGACAATFATCATCATATACAGACGACGACACGACATATCACACGACAGCATA"
//print( "结果: ", dna.indexesOf(ptnr: "CATA") )
//
//let concert = "🎼🎹🎹🎸🎸🎻🎻🎷🎺🎤👏👏👏"
//print( "结果: ", concert.indexesOf(ptnr: "🎻🎷") )


//let origin = "euroabadfryaabsabadffg"
//print(origin.indexesOf(ptnr: "abadfryaabsabadffg"))


let t = "GCACTGACTGACTGACTAG"
let p = "ACTGACTA"
print(t.indexesOf(ptnr: p))
