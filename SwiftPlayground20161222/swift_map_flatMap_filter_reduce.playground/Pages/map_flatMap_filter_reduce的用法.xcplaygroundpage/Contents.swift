//: [Previous](@previous)

import Foundation



let arrs = [2,4,5,1,7,1,8,9]

let temparr2 = arrs.map{$0 + 2}

let temparr = arrs.filter{$0 != 1}

let temp3 = arrs.reduce(1) { $0 * $1 }

print(temp3)
///打印：
///20160


//let arrs = [2,4,5,1,7,1,8,9]
////官方函数体写法
//let temparr = arrs.sorted{ (num1:Int, num2:Int) -> Bool in
//    return num1 > num2
//}
//
////sort函数包含函数体
//let temparr1 = arrs.sorted { (num1:Int, num2:Int) -> Bool in
//    return num1 > num2
//}
//
////省略形参名和返回值和in，用 $0 和 $1 代替形参
//let temparr2 = arrs.sorted(by: {$1 < $0})
//
////swift中运算符号也是一种特殊的函数
//let temparr3 = arrs.sorted(by: < )
//
//print(" temparr=\(temparr)\n temparr1=\(temparr1)\n temparr2=\(temparr2)\n temparr3=\(temparr3)")
///*打印：
// temparr=[9, 8, 7, 5, 4, 2, 1, 1]
// temparr1=[9, 8, 7, 5, 4, 2, 1, 1]
// temparr2=[9, 8, 7, 5, 4, 2, 1, 1]
// temparr3=[1, 1, 2, 4, 5, 7, 8, 9]
// */



//var arr = [1,2,3,4,5,6]
//let temparr = arr.reduce(0) { (item1: Int, item2:Int) -> Int in
//    return item1 + item2
//}
//print(temparr)
/////打印：
/////21





//var arr = [1,2,3,4,5,6]
//let temparr = arr.filter { (item: Int) -> Bool in
//    return item >= 3
//}
//print(temparr)
/////打印：
/////[3, 4, 5, 6]





//var arr = [1,2,3,4,5,6]
//var temparr = arr.map { (item: Int) -> Int in
//    return item + 1
//}
//print(temparr)
/////打印：
/////[2, 3, 4, 5, 6, 7]

//: [Next](@next)
