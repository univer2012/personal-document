//: Playground - noun: a place where people can play

import UIKit

//: ### Closures
let ten = 10
//closures有一个特点，会捕获变量。
//closure没有名字，必须赋值给一个变量
var addClosure: (Int, Int) -> Int = { (a: Int, b: Int) ->Int in
    return a + b
}
addClosure(5, 10)
// 例子2：
addClosure = { a, b in return a + b}

//: single expression closure
//swift编译器可以通过typeInfrenence 知道a、b以及返回的值都是Int类型。
//如果closure只有一条语句，类似例子中的，可以有更简单的写法：省略掉`return`,swift会直接把这条语句的返回值自动的作为整个closure的返回值。这样的closure在swift中叫`single expression closure`
addClosure = {a, b in a + b}
//: 符号化closure
//使用 $0,1,2,3 来引用closure中的参数：
addClosure = {$0 + $1}

//注意：不要在逻辑复杂的closure中使用这样的函数名，因为不利于理解代码逻辑。


//更普遍的closure用法：把closure变为函数的参数：
func execute(a: Int,_ b: Int, operation: (Int, Int)->Int) ->Int {
    return operation(a, b)
}
//接下来如何调用execute呢？先定义一个函数：
func addFunc(a: Int,_ b: Int)->Int {
    return a + b
}
//使用：传递一个函数
execute(a: 1, 10, operation: addFunc)
//也可以传递一个closure变量：
execute(a: 1, 10, operation: addClosure)
//本质上这2种调用是没有区别的，因为closure本身就是一个匿名函数。
//最完整的传递closure的调用：
execute(a: 1, 10, operation: {(a: Int,b: Int)->Int in
    return a + b
})
//去掉参数和返回值的描述：
execute(a: 1, 10, operation: { a, b in a + b})
//符号化：
execute(a: 1, 10, operation: {$0 + $1})
//如果operation是函数的最后一个参数，我们可以去掉这个参数的outname，并且把这个closure写到小括号外面去：
execute(a: 1, 10) {$0 + $1}
//这样的形式叫做`Trailing Closure`。如果closure本身逻辑很长，那么`trailing closure`可以让代码的可读性更好一些。


//:如果一个closure没有返回值，必须使用`Void`来写在closure返回值的地方，这是跟函数有所不同的：
let voidClosure: ()->Void = {print("Swift is fun")}



//closure与函数相比写起来更简单，还有一个重要特点，叫做`Capturing value`
//: #### Capturing value
//Scope 
//从scope说起，scope定义了swift中的各种实体，比如常量、函数在哪个范围里可以被访问。在我们的文件中，execute和voidClosure都在一个默认的`Global scope`里面，当我们使用`if {}` `while {}` `func {}`这样的语法结构时，我们使用的大括号就定义了一个新的Scope。我们在这个新的scope里面定义的任何东西，都是不能在global scope里面访问的。
//先看个例子：
var count = 0
let increment = { count = count + 1 }
increment()
increment()
increment()
increment()
increment()
count

//看一个closure捕获一个函数内部变量的例子：
func counting() ->() ->Int {
    var count = 0
    let incrementCount: ()->Int = { count = count + 1
        return count
    }
    return incrementCount
}
let c1 = counting()
c1()
c1()

//不同的closure会捕获到自己的变量：
let c2 = counting()
c2()
c2()
c2()






