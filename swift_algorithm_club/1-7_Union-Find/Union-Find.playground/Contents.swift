import UIKit

//var str = "Hello, playground"

public struct UnionFind<T: Hashable> {
    private var index = [T: Int]()
    private var parent = [Int]()
    private var size = [Int]()
}

/*:
 出于我们的目的，我们只需要跟踪每个树节点的父节点，而不是节点的子节点。 为此，我们使用数组parent，以便parent[i]是节点i的父节点的索引。
 
 示例：如果parent看起来像这样，
 ```
 parent [ 1, 1, 1, 0, 2, 0, 6, 6, 6 ]
      i   0  1  2  3  4  5  6  7  8
 ```
 然后树结构看起来像：
 ```
          1              6
        /   \           / \
       0      2        7   8
      / \    /
     3   5  4
 ```
 
 我们为每个子集提供唯一的编号以识别它。 该数字是该子集树的根节点的索引。在示例中，节点1是第一棵树的根，6是第二棵树的根。
 
 所以在这个例子中我们有两个子集，第一个带有标签1，第二个带有标签6。 Find操作实际上返回了set的标签，而不是其内容。
 
 请注意，根节点的parent []指向自身。 所以parent[1] = 1 和 parent [6] = 6。 这就是我们如何判断一些根节点的方法。
 */


//: ## Add set

extension UnionFind {
    public mutating func addSetWith(_ element: T) {
        index[element] = parent.count   // 1
        parent.append(parent.count)     // 2
        size.append(1)                  // 3
    }
}
/*:
 添加新元素时，实际上会添加一个仅包含该元素的新子集。
 
 1. 我们在`index`字典中保存新元素的索引。 这让我们可以在以后快速查找元素。
 
 2. 然后我们将该索引添加到`parent`数组中，为该集合构建一个新树。 这里，`parent[i]`指向自身，因为表示新集合的树只包含一个节点，当然这是该树的根。
 
 3. `size[i]`是树的节点数，其根位于索引`i`。 对于新集合，这是1，因为它只包含一个元素。 我们将在`Union`操作中使用`size`数组。

 */

/*:
 ## Find
 通常我们想确定我们是否已经有一个包含给定元素的集合。 这就是`Find`操作所做的。 在我们的`UnionFind`数据结构中，它被称为`setOf()`：
 */
extension UnionFind {
    public mutating func setOf(_ element: T) -> Int? {
        if let indexOfElement = index[element] {
            return setByIndex(indexOfElement)
        } else {
            return nil
        }
    }
    //
    private mutating func setByIndex(_ index: Int) -> Int {
        if parent[index] == index { // 1
            return index
        } else {
            parent[index] = setByIndex(parent[index])   // 2
            return parent[index]        // 3
        }
    }
}
/*:
 回想一下，每个集合由树表示，并且根节点的索引用作标识集合的数字。 我们将找到我们要搜索的元素所属的树的根节点，并返回其索引。
 
 
 
1. 首先，我们检查给定索引是否代表根节点（即“父”指向节点本身的节点）。 如果是这样，我们就完成了。
 
2. 否则，我们以递归方式在当前节点的父节点上调用此方法。 然后我们做了一个非常重要的事情：我们用根节点的索引覆盖当前节点的父节点，实际上将节点直接重新连接到树的根节点。 下次我们调用此方法时，它将执行得更快，因为树的根路径现在要短得多。 如果没有这种优化，这种方法的复杂性就是O(n)，但现在结合尺寸优化（在Union部分中说明）它几乎是O(1)。
 
 3. 我们返回根节点的索引作为结果。

 */

//: 还有一个帮助方法来检查两个元素是否在同一个集合中：
extension UnionFind {
    public mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            return firstSet == secondSet
        } else {
            return false
        }
    }
}

/*: ## Union (Weighted)
 最后的操作是 Union，它将两组合并为一组更大的组合。
 */

extension UnionFind {
    public mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {   // 1
            if firstSet != secondSet {                  // 2
                if size[firstSet] < size[secondSet] {   // 3
                    parent[firstSet] = secondSet        // 4
                    size[secondSet] += size[firstSet]   // 5
                } else {
                    parent[secondSet] = firstSet
                    size[firstSet] += size[secondSet]
                }
            }
        }
    }
}

/*:
 
 
 
1. 我们找到每个元素所属的集合。 请记住，这给了我们两个整数：parent数组中根节点的索引。
 
2. 检查这些集合是否相等，因为如果它们合并就没有意义。
 
3. 这是尺寸优化的来源（加权）。 我们希望保持树尽可能浅，所以我们总是将较小的树附加到较大树的根部。 为了确定哪个是较小的树，我们按照它们的大小比较树。
 
4. 这里我们将较小的树附加到较大树的根部。
 
5. 更新较大树的大小，因为它只添加了一堆节点。

 */

