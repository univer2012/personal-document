import UIKit

//var str = "Hello, playground"

/*:
 来自：[希尔排序(Shell Sort)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Shell%20Sort)
 
 [Shell Sort](https://github.com/andyRon/swift-algorithm-club/tree/master/Shell%20Sort)
 */

public func insertSort(_ list: inout[Int], start: Int, gap: Int) {
    for i in stride(from: (start + gap), to: list.count, by: gap) {
        let currentValue = list[i]
        var pos = i
        print("start = \(start), gap = \(gap), pos = \(pos), list[\(pos - gap)] = \(list[pos - gap]), currentValue = list[\(i)] = \(currentValue)")
        while pos >= gap && list[pos - gap] > currentValue {
            list[pos] = list[pos - gap]
            print("list[\(pos)] = \(list[pos])")
            pos -= gap
            print("pos = \(pos)")
        }
        list[pos] = currentValue
        print("list[\(pos)] = \(list[pos])")
    }
}

public func shellSort(_ list: inout [Int]) {
    var sublistCount = list.count / 2
    while sublistCount > 0 {
        for pos in 0 ..< sublistCount {
            insertSort(&list, start: pos, gap: sublistCount)
        }
        sublistCount = sublistCount / 2
    }
}

//测试
var arr = [64, 20, 50, 33, 72, 10, 23, -1, 4, 5]

shellSort(&arr)

print(arr)
