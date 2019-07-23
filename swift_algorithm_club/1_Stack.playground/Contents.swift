import UIKit

//var str = "Hello, playground"

/**:
 来自：
 [栈](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Stack)
 [Stack](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Stack)
 */

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

var stack = Stack<Int>()
stack.push(10)
stack.push(3)
stack.push(57)
stack.pop()
stack.pop()

