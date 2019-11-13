来自：[Swift错误处理](https://www.jianshu.com/p/b328c0dc2251?utm_campaign=haruki&utm_content=note&utm_medium=reader_share&utm_source=weixin)

#### 定义

错误处理是响应错误以及从错误中回复的过程，那这个过程包括抛出、捕获、传递和操作可恢复错误的支持。

#### 讨论

有些操作可能无法在所有的状态中都能返回一个有意义的值，当然可选类型可以帮忙表示失败的结果，但是错误处理可以让你更好的理解错误原因。
 swift关于错误处理的是协议Error，这个是一个控协议，可以通过**枚举**和**结构体**遵循这个协议来实现错误处理。

swift的异常处理有四种方式

- 通过函数的方式传递下去
- do-try-catch方式捕获
- try？将错误作为可选性处理，错误时返回nil。
- try！ 断言错误不会发生，但是如果发生了会有运行时错误。

#### 例子

举个自动贩卖机的例子。当我们去自动贩卖机买东西的时候，可能遇到以下问题

```swift
enum VendingMachineError: Error {
    case invalidSelection                   //选择无效
    case insufficientFunds(coinsNeeded: Int)//金额不足
    case outOfStock                         //缺货
}
```

接下来我们创建一个自动贩卖机类型

```swift
//商品结构体
struct Item {
    var price: Int
    var count: Int
}

//自动贩卖机
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 4)
    ]
    
    var coinsDesposited = 2
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDesposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDesposited)
        }
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("dispensing\(name)")
    }
}
```

由上可知，我们分别检验商品是否存在，库存是否充足以及投币是否足够。如果不满足就抛出异常。下面我们分别看一下上面说过的四种错误处理方式。
 可以看出在函数体后，返回值之前添加throws关键字表明该方法可能抛出异常。



