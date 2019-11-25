import UIKit

//var str = "Hello, playground"

let text = "HELLO WORLD"
//'encodedOffset' is deprecated: encodedOffset has been deprecated as most common usage is incorrect. Use utf16Offset(in:) to achieve the same behavior.
text.range(of: "ELLO")?.lowerBound.encodedOffset

text.range(of: "ELLO")?.lowerBound.utf16Offset(in: "ELLO")  // 1

text.range(of: "LD")?.lowerBound.utf16Offset(in: "") // 9

NSString(string: text).range(of: "WORLD").location // 6

extension String {
    
    fileprivate var skipTable: [Character: Int] {
        var skipTable: [Character: Int] = [:]
        for (i, c) in enumerated() {
            skipTable[c] = count - i - 1
        }
        return skipTable
    }
    fileprivate func match(from currentIndex: Index, with pattern: String) -> Index? {
        // 1
        if currentIndex < startIndex { return nil }
        if currentIndex >= endIndex { return nil }
        
        // 2
        if self[currentIndex] != pattern.last { return nil }
        print("pattern: ", pattern)
        if pattern.count == 1 && self[currentIndex] == pattern.last { return currentIndex }
        //pattern.dropLast() 是删除最后一个字符
        return match(from: self.index(before: currentIndex), with: "\(pattern.dropLast())")
    }
    
    func index(of pattern: String) -> String.Index? {
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= self.count else { return nil }
        
        let skipTable = pattern.skipTable
        let lastChar = pattern.last!
        
        var i = index(startIndex, offsetBy: patternLength - 1)
        print("before_i: \(i.utf16Offset(in: "")),  patternLength: \(patternLength)")
        while i < endIndex {
            let c = self[i]
            
            // 2
            print("i: \(i.utf16Offset(in: "")) --- c: \(c)")
            if c == lastChar {
                if let k = match(from: i, with: pattern) { return k }
                i = index(after: i)
            } else {
                // 3
                print("skipTable:\(c) -- \(skipTable[c] ?? 0)")
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
}

let text2 = "Hello World"
text2.index(of: "lo")?.utf16Offset(in: "") // returns 3
text2.index(of: "ld")?.utf16Offset(in: "") // returns 9

let sourceString = "Hello World!"
let pattern = "World"
if let index = sourceString.index(of: pattern) {
    print( index.utf16Offset(in: "")) // 6
}
/*打印结果：
 before_i: 4,  patternLength: 5
 i: 4 --- c: o
 skipTable:o -- 3
 i: 7 --- c: o
 skipTable:o -- 3
 i: 10 --- c: d
 pattern:  World
 pattern:  Worl
 pattern:  Wor
 pattern:  Wo
 pattern:  W
 6
 */

if let index = sourceString.index(of: pattern) {
    let intValue = sourceString.distance(from: sourceString.startIndex, to: index)
    print(intValue)  // 6
}


