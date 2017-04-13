//: Playground - noun: a place where people can play

import UIKit

let EAST = 1
let south = 2
let WEST = 3
let NORTH = 4
let months = ["January", "February", "March", "May", "June",
"July", "August", "SEptember", "October", "November", "December"]

//: #### Enum
//它有自己的属性，方法，还可以遵从protocol。
enum Dircetion: Int {
    case EAST = 2
    case SOUTH = 4
    case WEST = 6
    case NORTH = 8
}

enum Month: Int {
    case January = 1, Februray, March, April, May, June, July, August, September, November, December
}
let N = Dircetion.NORTH
let JAN = Month.January
//直观上看，使用enumation比使用数字或者字符串有诸多好处：1、可以使用Xcode的autocomplete来避免输入错误；2、使用enumation是类型安全的，当我们需要方向或者月份内容时，不会发生类型正确但是值却没有意义的情况。


//: #### Enum value
//enum的值可以通过多种不同的方式表达出来，而不像OC或者C语言一样，最终只能通过整数来替代。
func direction(val: Dircetion)->String {
    switch val {
    case .NORTH, .SOUTH:
        return "up down"
    case .EAST, .WEST:
        return "left right"
    }
}

//像C或者OC一样，手工绑定一个整数值。我们管这样手工绑定来的值叫做raw value
//: #### raw value
//在一个enum名字后面申明要绑定值的类型 :     enum Dircetion: Int

//为一个enum定义好value之后，我们可以通多rawValue属性来读取对应的值：
//let N = Dircetion.NORTH.rawValue
//还可以用rawValue来构建一个enum的值：
let S = Dircetion(rawValue: 4)     //Fialable initializer
//说明：由于不是所有的value都能够定位到对应的Dircetion，因此，这个Dircetion(rawValue: 4) 是一个Fialable initializer。如果查看`S`的类型，就会发现，它是一个Optional：
type(of:S)



//可以给每一个case单独绑定不同类型的值。管这样的值叫做 `Associated value`
//: #### Associated value
enum HTTPAction {
    case GET
    case POST(String)
    case PUT(Int,String)
}
let get = HTTPAction.GET
let post = HTTPAction.POST("BOXUE")
let put = HTTPAction.PUT(1, "Mars")

func actionDesc(action: HTTPAction) {
    switch action {
    case .GET:
        print("HTTP GET")
    case let .POST(msg):
        print("HTTP POST: \(msg)")
    case .PUT(let num, let name):
        print("HTTP PUT: \(num): \(name)")
    }
}
actionDesc(action: get)
actionDesc(action: post)
actionDesc(action: put)
//Swift中的optional是基于enum实现的。

//2种方式定义optional：
let address: String? = .some("Beijing") //nil
let address1: Optional<String> = .none //nil
//按住command点击Optional时，进去发现，Optional就是enum
//使用 .some("Beijing") 表示非空值，用  .none  表示空值




