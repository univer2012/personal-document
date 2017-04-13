//: Playground - noun: a place where people can play

import UIKit

//: #### Set
//每一个set都表达了一组类型相同但是值不相同的集合。
/*
 Characters box
 +------------+
 |   A   c    |
 |     b     i|
 | h        d |
 |    x   q   |
 |      z   o |
 +------------+
 */

//: Initialization
// Hashable set类型一定是可以被哈希的
//在前面介绍的所有swift中的基本类型都是可以被哈希的：
let number = 10
number.hashValue
let PI = 3.14
PI.hashValue
let string = "Swift"
string.hashValue

let emptySet: Set<Character> = Set<Character>()

// ["a", "e", "i", "o", "u"]
let vowel: Set<Character> = ["a", "e", "i", "o", "u"]
var evenSet: Set = [2,4,6,8,10]

//: Access and modifying a set 访问和修改set
//无需 在插入和删除时指定元素的位置
vowel.count
emptySet.isEmpty
evenSet.insert(12)
evenSet.remove(12)
evenSet.remove(14)
//evenSet.removeAll()
//是否包含某个元素：
evenSet.contains(10)

//: Iterating over a set  遍历一个集合
for number in evenSet {
    print(number)
}
//要把集合中的元素变成有序数组，就需要集合对象的sorted方法：
for number in evenSet.sorted() {
    print(number)
}

//: Set operation  在集合之间进行运算
var setA: Set = [1,2,3,4,5,6]
var setB: Set = [4,5,6,7,8,9]
//交集：
let interSectAB: Set = setA.intersection(setB)
//2个集合的对称差：
//let exclusiveAB: Set = setA.exclusiveOr(setB)
let exclusiveAB: Set = setA.symmetricDifference(setB)
//2个集合的并集：
let unionAB: Set = setA.union(setB)
//2个集合的补集：
let aSubstractB: Set = setA.subtracting(setB)


//: Set membership and Equality  判断2个集合关系的方法
var setC: Set = [1,2,3]
//是否相等：
if setA == setB {
    
} else {
    print("They are noe equal")
}
//A是否是C的超集：
setA.isSuperset(of: setC)
//C是否是A的子集：
setC.isSubset(of: setA)
//2个集合严格比较的函数： 是不是真子集的关系：
setA.isStrictSuperset(of: setC)
setC.isStrictSubset(of: setA)

//判断2个集合完全没有关系的方法：
setB.isDisjoint(with: setC) //setB 和 setC完全没有交集，所以返回的是true




//: #### Dictionary  字典
//: Init a dictionary 初始化字典
//var int2String: Dictionary<Int, String> = [Int: String]()
var int2String = [Int: String]()
int2String[10] = "Ten"
int2String[20] = "Twenty"
int2String = [:]
//给初始值：
var capitalNumber = [
    1 : "壹",
    "贰"
    "叁"
    "肆"
    "伍"
    "陆"
    "柒"
    "捌"
    "玖"
    "拾"
]




