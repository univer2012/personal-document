//: [Previous](@previous)

import UIKit

//let a: Int = 5
//var b: Int = a
//b = b + 1
//print(a, b)
/////打印：
/////5 6




//class Person {
//    var name: String = ""
//}
//
//let p1 = Person()
//p1.name = "name1"
//let p2 = p1
//p2.name = "name2"
//print(p1.name, p2.name)
/////打印：
/////name2 name2




//func test() {
//    var a: Int = 5
//    handle(a: &a)   //注意这里使用了取地址操作
//    print(a)        //output: 6
//}
//
//func handle(a: inout Int) {
//    print(a)        //output: 5
//    a = a + 1       // 如果没有inout修饰的话，这句代码将会报错，主要意思是不能改变一个let修饰的常量
//}
//
//test()



//func test() {
//    print("函数开始")
//    defer {
//        print("执行defer1")
//    }
//    print("函数将结束")
//    defer {
//        print("执行defer2")
//    }
//}
//test()
///*打印：
// 函数开始
// 函数将结束
// 执行defer2
// 执行defer1   */




//func test() {
//    print("函数开始")
//    defer {
//        print("执行defer1")
//    }
//
//    defer {
//        print("执行defer2")
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//        print("异步执行完毕")
//    }
//    print("函数将结束")
//}
//test()
///*打印：
// 函数开始
// 函数将结束
// 执行defer2
// 执行defer1
// 异步执行完毕   */




#if false
//错误类型枚举
enum MyError : Error {
    case ErrorOne
    case ErrorTwo
    case ErrorThree
    case ErrorOther
}

func willThrow(_ type:NSInteger)throws -> NSString{
    print("开始处理错误")
    if type == 1 {
        throw MyError.ErrorOne
    }else if type == 2 {
        throw MyError.ErrorTwo
    }else if type == 3{
        throw MyError.ErrorThree
    }else if type == 4{
        throw MyError.ErrorOther
    }
    return "一切都很好"
}
    
//调用
do {
    let str = try willThrow(5)
    //以下是非错误时的代码
    print(str) //如果有错误出现，这里将不会执行
}catch let err as MyError{
    print(err)
}catch{
    //这里必须要携带一个空的catch 不然会报错。 原因是可能遗漏
}
/*打印：
 开始处理错误
 ErrorTwo   */
#endif







//错误类型枚举
enum MyError : Error {
    case ErrorOne
    case ErrorTwo
    case ErrorThree
    case ErrorOther
}

func willThrow(_ type:Int)throws -> String{
    print("开始处理错误")
    if type == 1 {
        throw MyError.ErrorOne
    }else if type == 2 {
        throw MyError.ErrorTwo
    }else if type == 3{
        throw MyError.ErrorThree
    }else if type == 4{
        throw MyError.ErrorOther
    }
    return "一切都很好"
}
func willRethrow(_ throwCall: (Int) throws -> String) rethrows {
    do {
        let result = try throwCall(2)
        print(result)
    } catch let err as MyError {
        throw err       //这里进行了 再次throw
    } catch {
        
    }
}

//MARK:调用
let afunc = willThrow
do {
    try willRethrow(afunc)
} catch let err as MyError {
    print("rethrows ",err)
} catch {
    
}
/*打印：
 开始处理错误
 rethrows  ErrorTwo  */








//: [Next](@next)
