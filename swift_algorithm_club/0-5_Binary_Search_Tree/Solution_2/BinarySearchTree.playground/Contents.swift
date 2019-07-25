import UIKit

//var str = "Hello, playground"

/*:
 来自：[二叉搜索树(Binary Search Tree, BST)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Binary%20Search%20Tree)
 [Binary Search Tree (BST)](https://github.com/andyRon/swift-algorithm-club/tree/master/Binary%20Search%20Tree)
 */

public enum BinarySearchTree<T: Comparable> {
    case Empty
    case Leaf(T)
    indirect case Node(BinarySearchTree, T, BinarySearchTree)
}
extension BinarySearchTree {
    //计算树中节点数
    public var count: Int {
        switch self {
        case .Empty:
            return 0
        case .Leaf: return 1
        case let .Node(left, _, right): return left.count + 1 + right.count
        }
    }
    //树高
    public var height: Int {
        switch self {
        case .Empty: return 0
        case .Leaf: return 1
        case let .Node(left, _, right): return 1 + max(left.height, right.height)
        }
    }
}
extension BinarySearchTree {
    public func insert(newValue: T) -> BinarySearchTree {
        switch self {
        case .Empty:
            return .Leaf(newValue)
        case .Leaf(let value):
            if newValue < value {
                return .Node(.Leaf(newValue), value, .Empty)
            } else {
                return .Node(.Empty, value, .Leaf(newValue))
            }
        case .Node(let left, let value, let right):
            if newValue < value {
                return .Node(left.insert(newValue: newValue), value, right)
            } else {
                return .Node(left, value, right.insert(newValue: newValue))
            }
        }
    }
}

//测试
var tree = BinarySearchTree.Leaf(7)
tree = tree.insert(newValue: 2)
tree = tree.insert(newValue: 5)
tree = tree.insert(newValue: 10)
tree = tree.insert(newValue: 9)
tree = tree.insert(newValue: 1)

extension BinarySearchTree {
    // 搜索功能
    public func search(_ x: T) -> BinarySearchTree? {
        switch self {
        case .Empty:
            return nil
        case .Leaf(let y):
            return (x == y) ? self : nil
        case let .Node(left, y, right):
            if x < y {
                return left.search(x)
            } else if y < x {
                return right.search(x)
            } else {
                return self
            }
        }
    }
}

tree.search(10)
tree.search(1)
tree.search(11)  // nil

extension BinarySearchTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .Empty:
            return "."
        case .Leaf(let value): return "\(value)"
        case .Node(let left, let value, let right):
            return "(\(left.debugDescription) <- \(value) -> \(right.debugDescription))"
        }
    }
}
print(tree)     // ((1 <- 2 -> 5) <- 7 -> (9 <- 10 -> .))


