import UIKit

//var str = "Hello, playground"

/*:
 来自：[二叉搜索树(Binary Search Tree, BST)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Binary%20Search%20Tree)
 [Binary Search Tree (BST)](https://github.com/andyRon/swift-algorithm-club/tree/master/Binary%20Search%20Tree)
 */

public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    /// 是否是根节点
    public var isRoot: Bool {
        return parent == nil
    }
    /// 是否是叶节点
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    /// 是否是左子节点
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    /// 是否是右子节点
    public var isRightChild: Bool {
        return parent?.right === self
    }
    /// 是否有左子节点
    public var hasLeftChild: Bool {
        return left != nil
    }
    /// 是否有右子节点
    public var hasRightChild: Bool {
        return right != nil
    }
    /// 是否有子节点
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    /// 是否左右两个子节点都有
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    /// 当前节点包括子树中的所有节点总数
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    //: ## 插入节点
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
}

let tree = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])
//: ## 调试输出

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}

print("tree: ",tree.description)

//: ## 搜索

extension BinarySearchTree {
    #if false
    //使用递归
    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self //found it!
        }
    }
    #else
    //使用迭代
    public func search(value: T) -> BinarySearchTree? {
        var node: BinarySearchTree? = self
        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }
        return nil
    }
    #endif
}

print(tree.search(value: 5))    // Optional(5)
print(tree.search(value: 2))    // Optional((1) <- 2 -> (5))
print(tree.search(value: 7))    // Optional(((1) <- 2 -> (5)) <- 7 -> ((9) <- 10))
print(tree.search(value: 6))    // nil

//: ## 遍历

extension BinarySearchTree {
    //1. 中序（或 深度优先，In-order/depth-first）
    public func traverseInOrder(process: (T) -> Void) {
        
    }
    //2. 前序（Pre-order）
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    //3. 后序（Post-order）
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
}

tree.traverseInOrder { (value) in print(value) }

extension BinarySearchTree {
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left { a += left.map(formula: formula) }
        a.append(formula(value))
        if let right = right { a += right.map(formula: formula) }
        return a
    }
}
