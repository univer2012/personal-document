//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

//@autoclosure 可以说是Apple的一个非常神奇的创造，因为这更像是在hack”这门语言。简单说，@autoclosure 做的事情就是把一句表达式自动地封装成一个闭包(closure)。这样有时候在语法上看起来就会非常漂亮。

//比如我们有一个方法接受一个闭包，当闭包执行的结果为true的时候进行打印：
func logIfTrue(predicate: ()->Bool) {
    if predicate() {
        print("True")
    }
}

//在调用的时候，我们要写这样的代码：
logIfTrue({ return 2 > 1 })

//当然，在 Swift 中对闭包的用法可以进行一些简化，在这种情况下我们可以省略掉 return，写成：”
logIfTrue({ 2 > 1 })

//还可以更近一步，因为这个闭包是最后一个参数，所以可以使用尾随闭包 (trailing closure) 的方式把大括号拿出来，然后省略括号，变成：
logIfTrue{ 2 > 1 }

//但是不管哪种方式，要么书写起来十分麻烦，要么表达上不太清晰，看起来都让人很不舒服。于是@autoclosure登场了。我们可以改换方法参数，在参数名前面加上@autoclosure关键字：
func logIfTrue1(@autoclosure predicate: ()->Bool) {
    if predicate() {
        print("True")
    }
}

//这时候我们就可以直接写：
logIfTrue1(2 > 1)

//来进行调用了，Swift 将会把 2 > 1 这个表达式自动转换为 () -> Bool。这样我们就得到了一个写法简单，表意清楚的式子。







/*===========================================================================*/

//“在 Swift 中，有一个非常有用的操作符，可以用来快速地对 nil 进行条件判断，那就是 ??。这个操作符可以判断输入并在当左侧的值是非 nil 的 Optional 值时返回其 value，当左侧是 nil 时返回右侧的值，比如：
var level : Int?
var startLevel = 1
var currentLevel = level ?? startLevel

//“在这个例子中我们没有设置过 level，因此最后 startLevel 被赋值给了 currentLevel。如果我们充满好奇心地点进 ?? 的定义，可以看到 ?? 有两种版本：
#if false
func ??<T>(optional: T?, @autoclosure defaultValue: ()-> T?) ->T?
func ??<T>(optional: T?, @autoclosure defaultValue: ()-> T) -> T
#endif
//“在这里我们的输入满足的是后者，虽然表面上看 startLevel 只是一个 Int，但是其实在使用时它被自动封装成了一个 () -> Int，有了这个提示，我们不妨来猜测一下 ?? 的实现吧：
#if false
func ??<T>(optional: T?, @autoclosure defaultValue: ()->T)->T {
    switch optional {
    case .Some(let value):
        return value
    case .None:
        return defaultValue()
    }
}
#endif
//“可能你会有疑问，为什么这里要使用 autoclosure，直接接受 T 作为参数并返回不行么，为何要用 () -> T 这样的形式包装一遍，岂不是画蛇添足？其实这正是 autoclosure 的一个最值得称赞的地方。如果我们直接使用 T，那么就意味着在 ?? 操作符真正取值之前，我们就必须准备好一个默认值传入到这个方法中，一般来说这不会有很大问题，但是如果这个默认值是通过一系列复杂计算得到的话，可能会成为浪费 -- 因为其实如果 optional 不是 nil 的话，我们实际上是完全没有用到这个默认值，而会直接返回 optional 解包后的值的。这样的开销是完全可以避免的，方法就是将默认值的计算推迟到 optional 判定为 nil 之后。

//“就这样，我们可以巧妙地绕过条件判断和强制转换，以很优雅的写法处理对 Optional 及默认值的取值了。

//最后要提一句的是，@autoclosure 并不支持带有输入参数的写法，也就是说只有形如 () -> T 的参数才能使用这个特性进行简化。另外因为调用者往往很容易忽视 @autoclosure 这个特性，所以在写接受 @autoclosure 的方法时还请特别小心，如果在容易产生歧义或者误解的时候，还是使用完整的闭包写法会比较好。


















