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
//在树中添加`map()`方法
extension BinarySearchTree {
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left { a += left.map(formula: formula) }
        a.append(formula(value))
        if let right = right { a += right.map(formula: formula) }
        return a
    }
    public func toArray() -> [T] {
        return map { $0 }
    }
}
print(tree.toArray())   // [1, 2, 5, 7, 9, 10]

//: ## 删除节点

extension BinarySearchTree {
    //重新连接parent到 node节点
    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    //返回节点最小值
    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    //返回节点最大值
    public func maximum() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?
        
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node: replacement)
        
        //
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
}

//: ## 深度和高度
extension BinarySearchTree {
    // 高度
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    //深度，即某个节点所在的的深度
    public func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
        
    }
}
//测试
tree.height() // 2
if let node9 = tree.search(value: 9) {
    print(node9.depth()) // 2
}

//: ## 前驱节点和后继节点
extension BinarySearchTree {
    //获取前驱节点
    //predecessor: n. 前任，前辈
    /* 例子：
          7
         /   \
        2     10
       /  \   /
      1    5  9
     */
    public func predecessor() -> BinarySearchTree<T>? {
        if let left = left {
            return left.maximum()
        } else {//用【例子】查找9的前驱节点
            var node = self
            while let parent = node.parent {
                if parent.value < value { return parent }
                node = parent
            }
            return nil
        }
    }
    //后继节点
    //successor: n. 继承者；后续的事物
    /* 例子：
         7
        /  \
       2     10
      /  \   /
     1    5  9
     */
    public func successor() -> BinarySearchTree<T>? {
        if let right = right {
            return right.minimum()
        } else { //用【例子】查找5的后继节点
            var node = self
            while let parent = node.parent {
                if parent.value > value { return parent }
                node = parent
            }
            return nil
        }
    }
    // 这两种方法都在 O(h) 时间内运行。
}

//: ## 搜索树有效吗？
extension BinarySearchTree {
    // 检查树是否是有效的二叉搜索树
    public func isBST(minValue: T, maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
        return leftBST && rightBST
    }
}
//测试
if let node1 = tree.search(value: 1) {
    print( tree.isBST(minValue: Int.min, maxValue: Int.max) )   // true
    node1.insert(value: 100)                                    // EVIL!!! 罪恶，邪恶；不幸
    print( tree.search(value: 100) )                            // nil
    print( tree.isBST(minValue: Int.min, maxValue: Int.max) )   // false
}
