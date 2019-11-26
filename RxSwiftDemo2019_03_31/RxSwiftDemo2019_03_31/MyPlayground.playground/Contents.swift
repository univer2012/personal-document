import UIKit

//class Calcuator {
//    var a: Int = 1
//    var b: Int = 1
//
//    var sum: Int {
//        get {
//            return a + b
//        }
//        set(val) {
//            b = val - a
//        }
//    }
//}




//class Calcuator {
//    var a: Int = 1
//    var b: Int = 1
//
//    var sum: Int {
//        get {
//            return a + b
//        }
//        set {
//            b = newValue - a
//        }
//    }
//}



class Calcuator {
    var a: Int = 1
    var b: Int = 1
    
    var sum: Int {
        get {
            return a + b
        }
    }
}

let cal = Calcuator();
print(cal.sum)      //打印：2
cal.sum = 5
print(cal.b)        //打印：4
