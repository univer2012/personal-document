import UIKit

//var str = "Hello, playground"
//
//protocol Worker {
//    var job:String {get}
//    var workTime: Int {get}
//}
//struct Teacher:Worker {
//    let job = "teacher"
//    let workTime: Int = 8
//}
//struct Coder:Worker {
//    let job = "coder"
//    let workTime: Int = 10
//}
//extension Worker {
//    func getDesc() -> String {
//        return "I am a \(job), I work \(workTime) hours everday."
//    }
//}
//var coder = Coder()
//print(coder.getDesc())

///===========================
#if false//true
protocol DescriptionProtocol {
    func printSomething()
}

extension DescriptionProtocol {
    func printSomething() {
        print("This is a default implementation!")
    }
}
class SomeClass: DescriptionProtocol {
    var name: String?
}

//extension SomeClass: DescriptionProtocol {
//
//}
let someone = SomeClass()
someone.printSomething()
#endif

///===========================
#if false
let dic: [String: Any] = ["isShow": "0"]
if let isShow = dic["isShow"] as? String, isShow.isEmpty == false {
    print(isShow)
} else {
    print("none")
}

#endif









