//: Playground - noun: a place where people can play

import UIKit

//http://www.swiftv.cn/secure/course/ihwztn75/learn?lectureId=ihwztn750.08293035742826760.667191437445581#lesson/ihwztn750.08293035742826760.667191437445581

//: #### Collections

//: Ordered collectioin 有序集合
//:Unordered collection 无序集合
//说明：有序集合是指集合之间的元素是有位置关系的。
/*
 let boxue = ["B", "o", "x", "u", "e"]
 idx val
 +---+---+
 | 0 | B |
 +---+---+
 | 1 | o |
 +---+---+
 | 2 | x |
 +---+---+
 | 3 | u |
 +---+---+
 | 4 | e |
 +---+---+
 */

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



//: #### Array initialization 数组初始化
//空的整数数组：
var array1: Array<Int> = Array<Int>()
var array2: [Int] = array1
var array3 = array2
//包含一组默认值的数组:
var threeInts = [Int](repeating: 1,count: 3)//拥有3个元素，每个元素值是1
//可以把2个包含相同类型元素的数组相加来创建新的数组：
var sixInts = threeInts + threeInts
// [value1, value2, value3, value4]
var fiveInts = [1, 2, 3, 4, 5]

//: Access and Modigy an array  访问和修改数组中的元素

// Count 读取数组中元素的个数：
fiveInts.count
array1.count

// Empty 判断数组是否为空
fiveInts.count == 0
if array2.isEmpty {
    print("array2 is empty")
}

// Append 在数组末尾添加元素
array1.append(1)
array2 += [2, 3, 4]

//Indices 用下标访问数组中的元素
array2[2]
// 用range访问数组：
array2[0...1]
array2[1...2]
array2[0..<2]
//用range修改数组：
array2[0...1] = [6,5]
array2

// Insert and remove element at index 在数组的任意位置添加和删除元素：
array2.insert(6, at: 3)
array2.remove(at: 0)
array2
//删除最后一个元素的方法：
array2.removeLast()

//: iteration 遍历数组
for number in fiveInts {
    print(number)
}
//希望在数组的内部使用数组的索引，可以使用数组对象的enumerated方法：
fiveInts.enumerated()
for (index, value) in fiveInts.enumerated() {
    print("Index:\(index) value: \(value)")
}



