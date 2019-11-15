//: [Previous](@previous)

import UIKit

enum OperationError: Error {
    case ErrorOne
    case ErrorTwo
    case ErrorThree(String)
    case ErrorOther
}


func numberTest(num: Int) throws {
    if num == 1 {
        print("成功")
    } else if num == 2 {
        throw OperationError.ErrorTwo
    } else if num == 3 {
        throw OperationError.ErrorThree("失败")
    } else {
        throw OperationError.ErrorOther
    }
}

//错误传递
func throwDeliver(num: Int) throws -> String {
    print("错误传递")
    try numberTest(num: num)
    print("未传递错误")
    return "无错误"
}



//do-catch错误捕获
do {
    print("do-catch错误捕获")
    try throwDeliver(num: 5)
    print("未捕获错误")
} catch OperationError.ErrorOne {
    print("ErrorOne")
} catch OperationError.ErrorTwo {
    print("ErrorTwo")
} catch OperationError.ErrorThree(let discription) {
    print("ErrorThree:" + discription)
} catch let discription {
    print(discription)
}
/*打印：
 do-catch错误捕获
 错误传递
 ErrorOther   */


////错误转成可选值
//if let retureMessage = try? throwDeliver(num: 1) {
//    print("可选值非空：" + retureMessage)
//}
///*打印：
// 错误传递
// 成功
// 未传递错误
// 可选值非空：无错误 */



////禁止错误传递
//print(try! throwDeliver(num: 1) + ":禁止错误传递")
///*打印：
// 错误传递
// 成功
// 未传递错误
// 无错误:禁止错误传递 */


//: [Next](@next)
