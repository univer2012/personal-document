import UIKit

//var str = "Hello, playground"
/*
 来自：
 [队列](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Queue)
 
 [Queue](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Queue)
 */
#if false
public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}

//: ### 例子
var queue = Queue<String>()
queue.enqueue("Ada")
queue.enqueue("Steve")
queue.enqueue("Tim")
#endif

//: # 更加高效的队列

//: 改进版的队列的实现方式：

public struct Queue<T> {
    fileprivate var array = [T?]()
    fileprivate var head: Int = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        let percentage = Double(head) / Double(array.count)
        if array.count > 2 && percentage > 0.25 {
        //if head > 2 {//测试时注释上一行，打开这一行
            array.removeFirst(head)
            head = 0
        }
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

// 测试


var q = Queue<String>()
print(q.array)      // [] empty array

q.enqueue("Ada")
q.enqueue("Steve")
q.enqueue("Tim")
print(q.array)      // [Optional("Ada"), Optional("Steve"), Optional("Tim")]
print(q.count)      // 3

q.dequeue()
print(q.array)      // [nil, Optional("Steve"), Optional("Tim")]
print(q.count)      // 2

q.dequeue()
print(q.array)      // [nil, nil, Optional("Tim")]
print(q.count)      // 1

q.enqueue("Grace")
print(q.array)      // [nil, nil, Optional("Tim"), Optional("Grace")]
print(q.count)      // 2

q.dequeue()
print(q.array)      // [Optional("Grace")]
print(q.count)      // 1
