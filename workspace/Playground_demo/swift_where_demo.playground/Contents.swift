import UIKit

#if false
let scores = [20, 8, 59, 60, 70, 80]

//switch语句中使用
scores.forEach {
    switch $0 {
    case let x where x >= 60:
        print("及格")
    default:
        print("不及格")
    }
}

//for语句中使用
for score in scores where score >= 60 {
    print("这个是及格的：\(score)")
}
#endif


#if false
enum ExceptionError: Error {
    case httpCode(Int)
}
func throwError() throws {
    //print("hello!")  //正常的流程
    throw ExceptionError.httpCode(500) //抛出错误500
    //throw ExceptionError.httpCode(405) //抛出错误405
}

do {
    try throwError()
} catch ExceptionError.httpCode(let httpCode) where httpCode >= 500 {
    print("server error")
} catch {
    print("other error")
}
#endif

#if false
protocol aProtocol { }

//只给遵守aProtocol协议的UIView添加了拓展
extension aProtocol where Self: UIView {
    func getString() -> String {
        return "string"
    }
}

class myView: UIView, aProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    //myView属于UIView的子类，所以要实现aProtocol协议
//    func getString() -> String {
//        return "It is a UIView."
//    }
}
//myViewController不属于UIView的子类，即使遵从aProtocol协议，但是不用实现该协议里面的内容
class myViewController: UIViewController, aProtocol {
    
}




var optionName: String? = "Hangge"
if let name = optionName, name.hasPrefix("H") {
    print("\(name)")
}
#endif

protocol MyProtocol {
    associatedtype Element
    associatedtype SubSequence: Sequence where SubSequence.Iterator.Element == Element
}

///Numeric  [njuː'merɪk] adj. 数值的（等于 numerical）；数字的           n. 数；数字
extension Sequence where Element: Numeric {
    var sum: Element {
        var result: Element = 0
        for item in self {
            result += item
        }
        return result
    }
}

print([1, 2, 3, 4].sum)
//print(["a", "b", "c"].su)



// 在Swift 3时代, 这种扩展需要很多的约束:
//extension Collection where Iterator.Element: Equatable,
//    SubSequence: Sequence,
//    SubSequence.Iterator.Element == Iterator.Element
//
// 而在Swift 4, 编译器已经提前知道了上述3个约束中的2个, 因为可以用相关类型的where语句来表达它们.
extension Collection where Element: Equatable {
    func prefieIsEqualSuffix(_ n: Int) -> Bool {
        let head = prefix(n)
        let suff = suffix(n).reversed()
        return head.elementsEqual(suff)
    }
}

print([1,2,3,4,2,1].prefieIsEqualSuffix(2))


