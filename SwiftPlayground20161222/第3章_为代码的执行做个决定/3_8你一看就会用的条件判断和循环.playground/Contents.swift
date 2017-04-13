//: Playground - noun: a place where people can play

import UIKit

//: ### Basic Loop and condition control
// for / while
// if / switch

//: for
//for var i=0; i<10; i = i + 1 {
//    print(i)
//}
let vowel = ["a", "e", "i", "o", "u"]
for char in vowel {
    print(char)
}

for number in 1...100 {
    print(number)
}

//有时仅仅需要for来执行固定次数的循环，而不关心循环变量的每一个值，这时可以在number的位置使用一个下横线来替代它。
for _ in 1...10 {
    print("*", terminator:"")
}

//: while
var i = 0
while i<10 {
    print(i)
    i += 1
}

//: do ... while
var n = 0
repeat {
    print(vowel[n])
    n = n + 1
} while n<5


//: if
var PI = 3.14
if PI == 3.14 {
    
}
else if PI == 3.14159 {
    
}
else if PI == 3.1415926 {
    
}
else {
    
}
//:用if 来处理 optional
var person: String? = "Mars"
if let person = person {
    print("Hello \(person)")
}
else {
    print("Hello everyone")
}






